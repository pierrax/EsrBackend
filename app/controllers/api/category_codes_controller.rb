class Api::CategoryCodesController < Api::BaseController
  before_action :set_category_code, except: %i[create index]

  swagger_controller :codes, 'Type de codes des établissements'

  swagger_api :create do
    summary 'Create a category code'
    notes 'Crée un type de code'
    param :string, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a category code'
    notes 'Afficher un type de code'
    param :integer, :category_code_id, :integer, :required, 'Category code ID'
  end

  swagger_api :update do
    summary 'Update a category code'
    notes 'Mettre à jour un type de code'
    param :integer, :category_code_id, :integer, :required, 'Category code ID'
  end

  swagger_api :destroy do
    summary 'Delete a category code'
    notes 'Effacer un type de code'
    param :integer, :category_code_id, :integer, :required, 'Category code ID'
  end

  def create
    @category_code = CategoryCode.new(category_code_params)
    if @category_code.save
      respond_with @category_code
    else
      p @category_code.errors
      return not_saved
    end
  end

  def show
    respond_with @category_code
  end

  def update
    if @category_code.update(category_code_params)
      respond_with @category_code
    else
      return not_saved
    end
  end

  def destroy
    @category_code.destroy
    render json: { message: 'Category Code deleted' }, status: 200
  end

  def index
    @category_codes = CategoryCode.all
  end

  private

  def set_category_code
    @category_code = CategoryCode.find(params[:id])
    return not_found unless @category_code
  end

  def category_code_params
    params[:category_code].permit(
        :title
    )
  end
end
