class Api::InstitutionConnectionCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  swagger_controller :connection_categories, 'Type de connection entre établissements'

  swagger_api :index do
    summary 'Returns all connection categories'
    notes 'Tous les types de connection'
  end

  swagger_api :create do
    summary 'Create a connection category'
    notes 'Créer un type de connection'
    param :query, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a connection category'
    notes 'Afficher un type de connection'
    param :query, :connection_category_id, :integer, :required, 'Connection Category ID'
  end

  swagger_api :update do
    summary 'Update a connection category'
    notes 'Mettre à jour un type de connection'
    param :query, :connection_category_id, :integer, :required, 'Connection Category ID'
    param :body, :title, :json, :required, 'Title'
  end

  swagger_api :destroy do
    summary 'Delete a connection category'
    notes 'Effacer un type de connection'
    param :query, :connection_category_id, :integer, :required, 'Connection Category ID'
  end

  def create
    @category = InstitutionConnectionCategory.new(category_params)
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
    if @category.update(category_params)
      respond_with @category
    else
      return not_saved
    end
  end

  def destroy
    @category.destroy
    render json: { message: 'Institution Connection Category deleted' }, status: 200
  end

  def index
    @categories = InstitutionConnectionCategory.all
    respond_with @categories
  end

  private

  def set_category
    @category = InstitutionConnectionCategory.find(params[:id])
    return not_found unless @category
  end

  def category_params
    params[:institution_connection_category].permit(
        :title
    )
  end
end
