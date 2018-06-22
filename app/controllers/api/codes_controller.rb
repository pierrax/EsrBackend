class Api::CodesController < Api::BaseController
  before_action :set_code, except: %i[create index search export import]
  skip_before_action :authenticate_request, only: :search

  swagger_controller :codes, 'Codes des établissements'

  swagger_api :index do
    summary 'Returns all codes for an institution'
    notes 'Tous les codes pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :create do
    summary 'Create a code'
    notes 'Crée un code pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
    param :query, :category_code_id, :integer, :required, 'Category code ID'
  end

  swagger_api :show do
    summary 'Show a code'
    notes 'Afficher un code'
    param :query, :code_id, :integer, :required, 'code ID'
  end

  swagger_api :update do
    summary 'Update a code'
    notes 'Mettre à jour un code'
    param :integer, :code_id, :integer, :required, 'code ID'
  end

  swagger_api :destroy do
    summary 'Delete a code'
    notes 'Effacer un code'
    param :query, :code_id, :integer, :required, 'code ID'
  end

  swagger_api :search do
    summary 'Returns all codes with content matches'
    notes 'Filtre les codes par contenu'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :q, :string, :required, 'Query string'
  end

  swagger_api :import do
    summary 'Import codes with CSV file'
    notes 'Créer / MAJ des codes'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  swagger_api :export do
    summary 'Export codes with CSV file'
    notes 'Créer / MAJ des codes'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
  end
  
  def create
    @institution = Institution.find(params[:institution_id])
    @code = @institution.codes.create!(code_params)
    respond_with @code
  end

  def show
    respond_with @code
  end

  def update
    @code.update!(code_params)
    respond_with @code
  end

  def destroy
    @code.destroy
    render json: { message: 'Code deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @codes = @institution.codes.ordered_by_category
  end

  def search
    @code = Code.where(content: params[:q]).first
    if @code
      @active = params[:status] == 'active'
      @institution = @code.try(:institution)
    else
      render json: { message: 'No institution' }, status: 200
    end
  end

  def import
    import_response = ImportCodes.new(params[:file].tempfile).call
    if import_response == true
      render json: { message: 'Codes uploaded' }, status: 200
    else
      render json: { message: import_response }, status: 401
    end
  end

  def export
    @codes = Code.all
    export_csv = ExportCodes.new(@codes).call
    send_data export_csv, type: 'text/csv', disposition: 'inline'
  end

  private

  def set_code
    @code = Code.find(params[:id])
    return not_found unless @code
  end

  def code_params
    params[:code].permit(
        :content,
        :institution_id,
        :code_category_id,
        :date_start,
        :date_end,
        :status
    )
  end
end
