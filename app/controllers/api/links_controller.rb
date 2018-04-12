class Api::LinksController < Api::BaseController
  before_action :set_link, except: %i[create index]

  swagger_controller :links, 'Liens des établissements'

  swagger_api :create do
    summary 'Create a link'
    notes 'Crée un lien pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :integer, :category_link_id, :integer, :required, 'Category link ID'
  end

  swagger_api :index do
    summary 'Returns all links for an institution'
    notes 'Tous les liens pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :show do
    summary 'Show a link'
    notes 'Afficher un lien'
    param :integer, :link_id, :integer, :required, 'link ID'
  end

  swagger_api :update do
    summary 'Update a link'
    notes 'Mettre à jour un lien'
    param :integer, :link_id, :integer, :required, 'link ID'
  end

  swagger_api :destroy do
    summary 'Delete a link'
    notes 'Effacer un lien'
    param :integer, :link_id, :integer, :required, 'link ID'
  end

  def create
    @institution = Institution.find(params[:institution_id])
    @link = @institution.links.new(link_params)
    if @link.save
      @link
    else
      p @link.errors
      return not_saved
    end
  end

  def show
    respond_with @link
  end

  def update
    if @link.update(link_params)
      respond_with @link
    else
      return not_saved
    end
  end

  def destroy
    @link.destroy
    render json: { message: 'Link deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @links = @institution.links
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
