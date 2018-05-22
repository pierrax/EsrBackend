class Api::InstitutionEvolutionCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  swagger_controller :evolution_categories, "Type d'evolution entre établissements"

  swagger_api :index do
    summary 'Returns all evolution categories'
    notes "Tous les types d'evolution"
  end

  swagger_api :create do
    summary 'Create a evolution category'
    notes 'Créer un type de evolution'
    param :query, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a evolution category'
    notes 'Afficher un type de evolution'
    param :query, :evolution_category_id, :integer, :required, 'Evolution Category ID'
  end

  swagger_api :update do
    summary 'Update a evolution category'
    notes 'Mettre à jour un type de evolution'
    param :query, :evolution_category_id, :integer, :required, 'Evolution Category ID'
    param :body, :title, :json, :required, 'Title'
  end

  swagger_api :destroy do
    summary 'Delete a evolution category'
    notes 'Effacer un type de evolution'
    param :query, :evolution_category_id, :integer, :required, 'Evolution Category ID'
  end
  
  def create
    @category = InstitutionEvolutionCategory.new(category_params)
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
    render json: { message: 'Institution Evolution Category deleted' }, status: 200
  end

  def index
    @categories = InstitutionEvolutionCategory.all
    respond_with @categories
  end

  private

  def set_category
    @category = InstitutionEvolutionCategory.find(params[:id])
    return not_found unless @category
  end

  def category_params
    params[:institution_evolution_category].permit(
        :title
    )
  end
end
