class Api::InstitutionsController < Api::BaseController
  before_action :set_institution, except: %i[create index search import last]

  swagger_controller :institutions, "Les établissements de l'ESR"

  swagger_api :index do
    summary 'Returns all institutions'
    notes 'Tous les établissements de l ESR'
  end

  swagger_api :last do
    summary 'Returns last institutions created'
    notes 'Derniers établissements de l ESR créés'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :size, :integer, :optional, 'Number of Institutions (20 by default)'
  end

  swagger_api :search do
    summary 'Returns all institutions with name or initials matches'
    notes "Filtre les établissements de l'ESR par nom ou sigle"
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :q, :string, :required, 'Query string'
    param :query, :download, :boolean, :optional, 'Download CSV'
  end

  swagger_api :create do
    summary 'Create an institution'
    notes 'Créer un établissement'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :name, :string, :optional, 'Institution Name'
    param :query, :initials, :string, :optional, 'Institution Initials'
    param :query, :date_start, :string, :optional, 'Institution date start'
    param :query, :date_end, :string, :optional, 'Institution date end'
    param :query, :synonym, :string, :optional, 'Institution synonyms'
  end

  swagger_api :show do
    summary 'Show an institution'
    notes 'Afficher un établissement'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :update do
    summary 'Update an institution'
    notes 'Mettre à jour un établissement'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :destroy do
    summary 'Delete an institution'
    notes 'Effacer un établissement'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :import do
    summary 'Import institutions with CSV file'
    notes 'Créer / MAJ des établissements'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  def create
    if params[:institution][:name].present? || params[:institution][:initials].present?
      params[:institution][:names_attributes] = [{ text: params[:institution][:name], initials: params[:institution][:initials], insitution_id: params[:institution_id]  }]
    end
    @institution = Institution.create!(institution_params)
  end

  def show
  end

  def update
    @institution.update!(institution_params)
  end

  def destroy
    @institution.destroy
    render json: { message: 'Institution deleted' }, status: 200
  end

  def index
    institutions = Institution.includes(:names, :addresses, :links, { :links => :category }, :codes, :tags, { :tags => :category }, :predecessors, :followers, :mothers, :daughters, ).all
    headers['Count'] = institutions.count
    @institutions = institutions.page(params[:page_number]).per(params[:page_size])
    paginator @institutions, params.permit!
    respond_with @institutions
  end

  def search
    if params[:download] == 'true'
      export_csv = ExportInstitutions.new(params[:q]).call
      send_data export_csv, type: 'text/csv', disposition: 'inline'
    else
      institutions = Institution.includes(:names, :addresses, :codes, :tags, { :tags => :category }).with_name_or_initials(params[:q]).distinct
      headers['Count'] = institutions.count
      @institutions = institutions.page(params[:page_number]).per(params[:page_size])
      paginator @institutions, params.permit!
    end
  end

  def import
    return params_not_found unless params[:file]
    import_response = ImportInstitutions.new(params[:file].tempfile).call
    if import_response == true
      render json: { message: 'Institution uploaded' }, status: 200
    else
      render json: { message: import_response }, status: 400
    end
  end

  def last
    @institutions = Kaminari.paginate_array(Institution.last(params[:size] || 20)).page(params[:page_number]).per(params[:page_size])
    paginator @institutions, params.permit!
  end

  private

  def set_institution
    @institution = Institution.find(params[:id] || params[:institution_id])
  end

  def institution_params
    params[:institution].permit(
        :date_start,
        :date_end,
        :synonym,
        names_attributes: [:text, :initials]
    )
  end
end
