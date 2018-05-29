class Api::InstitutionNamesController < Api::BaseController
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_institution_name, except: %i[create index]

  swagger_controller :institution_names, "Les Noms des établissements de l'ESR"

  swagger_api :index do
    summary 'Returns all institution names'
    notes "Tous les noms d'un établissement de l'ESR"
  end

  swagger_api :create do
    summary 'Create an institution name'
    notes "Créer un nom d'établissement"
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :body, :institution_name, :json, :optional, 'Institution Name', { "schema": [{ "type": "object" }, { "properties": [ {"text": [ "type": "string"]} ] }] }
  end

  swagger_api :show do
    summary 'Show an institution name'
    notes "Afficher un nom d'établissement"
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :institution_name_id, :integer, :required, 'Institution Name ID'
  end

  swagger_api :update do
    summary 'Update an institution name'
    notes "Mettre à jour un nom d'établissement"
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :institution_name_id, :integer, :required, 'Institution Name ID'
  end

  swagger_api :destroy do
    summary 'Delete an institution'
    notes "Effacer à jour un nom d'établissement"
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :institution_name_id, :integer, :required, 'Institution Name ID'
  end

  def create
    @institution = Institution.find(params[:institution_id])
    @institution_name = @institution.names.create!(institution_name_params)
    respond_with @institution_name
  end

  def show
    respond_with @institution_name
  end

  def update
    @institution_name.update!(institution_name_params)
    respond_with @institution_name
  end

  def destroy
    @institution_name.destroy
    render json: { message: 'Institution deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @institution_names = @institution.names
  end

  private

  def set_institution_name
    @institution_name = InstitutionName.find(params[:id])
  end

  def institution_name_params
    params[:institution_name].permit(
        :text,
        :initials,
        :date_start,
        :date_end,
        :status
    )
  end
end
