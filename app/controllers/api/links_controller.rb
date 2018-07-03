class Api::LinksController < Api::BaseController
  before_action :set_link, except: %i[create index import export]

  swagger_controller :links, 'Liens des établissements'

  swagger_api :create do
    summary 'Create a link'
    notes 'Créer un lien pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :query, :link_category_id, :integer, :required, 'Category link ID'
    param :query, :content, :string, :required, 'Content link'
  end

  swagger_api :index do
    summary 'Returns all links for an institution'
    notes 'Tous les liens pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :show do
    summary 'Show a link'
    notes 'Afficher un lien'
    param :query, :link_id, :integer, :required, 'link ID'
  end

  swagger_api :update do
    summary 'Update a link'
    notes 'Mettre à jour un lien'
    param :query, :link_id, :integer, :required, 'link ID'
  end

  swagger_api :destroy do
    summary 'Delete a link'
    notes 'Effacer un lien'
    param :query, :link_id, :integer, :required, 'link ID'
  end

  swagger_api :import do
    summary 'Import links with CSV file'
    notes 'Créer / MAJ des liens'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  swagger_api :export do
    summary 'Export links with CSV file'
    notes 'Créer / MAJ des liens'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
  end

  def create
    @institution = Institution.find(params[:institution_id])
    @link = @institution.links.create!(link_params)
    respond_with @link
  end

  def show
    respond_with @link
  end

  def update
    @link.update!(link_params)
    respond_with @link
  end

  def destroy
    @link.destroy
    render json: { message: 'Link deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @links = @institution.links.ordered_by_category
  end

  def import
    import_response = ImportLinks.new(params[:file].tempfile).call
    if import_response == true
      render json: { message: 'Links uploaded' }, status: 200
    else
      render json: { message: import_response }, status: 401
    end
  end

  def export
    @links = Link.all
    export_csv = ExportLinks.new(@links).call
    send_data export_csv, type: 'text/csv', disposition: 'inline'
  end

  private

  def set_link
    @link = Link.find(params[:id])
    return not_found unless @link
  end

  def link_params
    params[:link].permit(
        :content,
        :institution_id,
        :link_category_id,
        :date_start,
        :date_end,
        :status
    )
  end
end
