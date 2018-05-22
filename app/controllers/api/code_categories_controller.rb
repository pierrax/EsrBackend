class Api::CodeCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  swagger_controller :codes, 'Type de codes des établissements'

  swagger_api :index do
    summary 'Returns all code categories'
    notes 'Tous les types de codes'
  end

  swagger_api :create do
    summary 'Create a code category'
    notes 'Créer un type de code'
    param :query, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a code category'
    notes 'Afficher un type de code'
    param :query, :code_category_id, :integer, :required, 'Code category ID'
  end

  swagger_api :update do
    summary 'Update a code category'
    notes 'Mettre à jour un type de code'
    param :query, :code_category_id, :integer, :required, 'Code category ID'
  end

  swagger_api :destroy do
    summary 'Delete a code category'
    notes 'Effacer un type de code'
    param :query, :code_category_id, :integer, :required, 'Code category ID'
  end

  def create
    @category = CodeCategory.new(code_category_params)
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
    if @category.update(code_category_params)
      respond_with @category
    else
      p @category.errors
      return not_saved
    end
  end

  def destroy
    @category.destroy
    render json: { message: 'Code Category deleted' }, status: 200
  end

  def index
    @categories = CodeCategory.all
  end

  private

  def set_category
    @category = CodeCategory.find(params[:id])
    return not_found unless @category
  end

  def code_category_params
    params[:code_category].permit(
        :title
    )
  end
end
