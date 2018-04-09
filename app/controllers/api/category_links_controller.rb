class Api::CategoryLinksController < Api::BaseController
  before_action :set_category_link, except: %i[create index]

  swagger_controller :liens, 'Type de liens des établissements'

  swagger_api :create do
    summary 'Create a category link'
    notes 'Crée un type de lien'
    param :string, :title, :string, :required, 'Title'
  end

  swagger_api :show do
    summary 'Show a category lien'
    notes 'Afficher un type de lien'
    param :integer, :category_lien_id, :integer, :required, 'Category lien ID'
  end

  swagger_api :update do
    summary 'Update a category lien'
    notes 'Mettre à jour un type de lien'
    param :integer, :category_lien_id, :integer, :required, 'Category lien ID'
  end

  swagger_api :destroy do
    summary 'Delete a category lien'
    notes 'Effacer un type de lien'
    param :integer, :category_lien_id, :integer, :required, 'Category lien ID'
  end
  
  def create
    @category_link = CategoryLink.new(category_link_params)
    if @category_link.save
      respond_with @category_link
    else
      p @category_link.errors
      return not_saved
    end
  end

  def show
    respond_with @category_link
  end

  def update
    if @category_link.update(category_link_params)
      respond_with @category_link
    else
      return not_saved
    end
  end

  def destroy
    @category_link.destroy
    render json: { message: 'Category Link deleted' }, status: 200
  end

  def index
    @category_links = CategoryLink.all
  end

  private

  def set_category_link
    @category_link = CategoryLink.find(params[:id])
    return not_found unless @category_link
  end

  def category_link_params
    params[:category_link].permit(
      :title
    )
  end
end
