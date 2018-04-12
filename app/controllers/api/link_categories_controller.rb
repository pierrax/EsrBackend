class Api::LinkCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  swagger_controller :liens, 'Type de liens des établissements'

  swagger_api :create do
    summary 'Create a  link category'
    notes 'Crée un type de lien'
    param :string, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a link category'
    notes 'Afficher un type de lien'
    param :integer, :link_category_id, :integer, :required, 'Link Category ID'
  end

  swagger_api :update do
    summary 'Update a link category'
    notes 'Mettre à jour un type de lien'
    param :integer, :link_category_id, :integer, :required, 'Link Category ID'
  end

  swagger_api :destroy do
    summary 'Delete a link category'
    notes 'Effacer un type de lien'
    param :integer, :link_category_id, :integer, :required, 'Link Category ID'
  end
  
  def create
    @category = LinkCategory.new(link_category_params)
    if @category.save
      respond_with @category
    else
      p @category.errors
      return not_saved
    end
  end

  def show
    respond_with @category
  end

  def update
    if @category.update(link_category_params)
      respond_with @category
    else
      return not_saved
    end
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
    params[:link_category].permit(
      :title
    )
  end
end