class Api::LinkCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  swagger_controller :liens, 'Type de liens des établissements'

  swagger_api :index do
    summary 'Returns all link categories'
    notes 'Tous les types de lien'
  end

  swagger_api :create do
    summary 'Create a link category'
    notes 'Créer un type de lien'
    param :query, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a link category'
    notes 'Afficher un type de lien'
    param :query, :link_category_id, :integer, :required, 'Link Category ID'
  end

  swagger_api :update do
    summary 'Update a link category'
    notes 'Mettre à jour un type de lien'
    param :query, :link_category_id, :integer, :required, 'Link Category ID'
  end

  swagger_api :destroy do
    summary 'Delete a link category'
    notes 'Effacer un type de lien'
    param :query, :link_category_id, :integer, :required, 'Link Category ID'
  end
  
  def create
    @category = LinkCategory.create!(link_category_params)
    respond_with @category
  end

  def show
    respond_with @category
  end

  def update
    @category.update!(link_category_params)
    respond_with @category
  end

  def destroy
    @category.destroy
    render json: { message: 'Link Category deleted' }, status: 200
  end

  def index
    @categories = LinkCategory.all
  end

  private

  def set_category
    @category = LinkCategory.find(params[:id])
    return not_found unless @category
  end

  def link_category_params
    params[:link_category].permit(:title, :position)
  end
end
