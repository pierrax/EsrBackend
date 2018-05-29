class Api::InstitutionTagCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  swagger_controller :tag_categories, 'Type de tags des établissements'

  swagger_api :index do
    summary 'Returns all tag categories'
    notes 'Tous les types de tag'
  end

  swagger_api :create do
    summary 'Create a tag category'
    notes 'Créer un type de tag'
    param :query, :short_labl, :string, :required, 'Short label'
    param :query, :long_label, :string, :required, 'Long label'
    param :query, :institution_tag_category_id, :string, :required, 'Tag Category ID'
  end

  swagger_api :show do
    summary 'Show a tag category'
    notes 'Afficher un type de tag'
    param :query, :tag_category_id, :integer, :required, 'Tag Category ID'
  end

  swagger_api :update do
    summary 'Update a tag category'
    notes 'Mettre à jour un type de tag'
    param :query, :tag_category_id, :integer, :required, 'Tag Category ID'
    param :query, :short_labl, :string, :required, 'Short label'
    param :query, :long_label, :string, :required, 'Long label'
  end

  swagger_api :destroy do
    summary 'Delete a tag category'
    notes 'Effacer un type de tag'
    param :query, :tag_category_id, :integer, :required, 'Tag Category ID'
  end

  def create
    @category = InstitutionTagCategory.create!(category_params)
    respond_with @category
  end

  def show
    respond_with @category
  end

  def update
    @category.update!(category_params)
    respond_with @category
  end

  def destroy
    @category.destroy
    render json: { message: 'Institution Tag Category deleted' }, status: 200
  end

  def index
    @categories = InstitutionTagCategory.all
  end

  private

  def set_category
    @category = InstitutionTagCategory.find(params[:id])
    return not_found unless @category
  end

  def category_params
    params[:institution_tag_category].permit(
        :title,
        :origin
    )
  end
end
