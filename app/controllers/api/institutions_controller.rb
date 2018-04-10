class Api::InstitutionsController < Api::BaseController
  before_action :set_institution, except: %i[create index search]

  swagger_controller :institutions, "Les établissements de l'ESR"

  swagger_api :index do
    summary 'Returns all institutions'
    notes 'Tous les établissements de l ESR'
  end

  swagger_api :search do
    summary 'Returns all institutions with name or initials matches'
    notes 'Filtre les établissements de l ESR par nom ou sigle'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :q, :string, :required, 'query string'
  end

  swagger_api :create do
    summary 'Create an institution'
    notes 'Créer un établissement'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :name, :string, :optional, 'Institution Name'
    param :query, :initials, :string, :optional, 'Institution Initials'
    param :query, :date_start, :string, :optional, 'Institution date start'
    param :query, :date_end, :string, :optional, 'Institution date end'
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

  def create
    if params[:institution][:name].present? || params[:institution][:initials].present?
      params[:institution][:names_attributes] = [{ text: params[:institution][:name], initials: params[:institution][:initials], insitution_id: params[:institution_id]  }]
    end
    @institution = Institution.new(institution_params)
    if @institution.save
      # respond_with @institution
    else
      p @institution.errors
      return not_found
    end
  end

  def show
    # respond_with @institution
  end

  def update
    if @institution.update(institution_params)
      # respond_with @institution
    else
      return not_found
    end
  end

  def destroy
    @institution.destroy
    render json: { message: 'Institution deleted' }, status: 200
  end

  def index
    @institutions = Institution.all
    respond_with @institutions
  end

  def search
    @institutions = Institution.with_name_or_initials(params[:q]).uniq
  end

  private

  def set_institution
    @institution = Institution.find(params[:id])
  end

  def institution_params
    params[:institution].permit(
        :date_start,
        :date_end,
        names_attributes: [:text, :initials]
    )
  end

end
