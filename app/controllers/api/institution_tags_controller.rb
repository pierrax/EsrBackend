class Api::InstitutionTagsController < Api::BaseController
  before_action :set_tag, except: %i[create index]

  swagger_controller :tags, 'Tags des établissements'

  swagger_api :index do
    summary 'Returns all tags for an institution'
    notes 'Tous les tags pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :create do
    summary 'Create a tag'
    notes 'Créer un tag pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :query, :category_tag_id, :integer, :required, 'Category tag ID'
    param :query, :content, :string, :required, 'Content tag'
  end

  swagger_api :show do
    summary 'Show a tag'
    notes 'Afficher un tag'
    param :query, :tag_id, :integer, :required, 'tag ID'
  end

  swagger_api :update do
    summary 'Update a tag'
    notes 'Mettre à jour un tag'
    param :query, :tag_id, :integer, :required, 'tag ID'
  end

  swagger_api :destroy do
    summary 'Delete a tag'
    notes 'Effacer un tag'
    param :query, :tag_id, :integer, :required, 'tag ID'
  end
  
  def create
    @tag = InstitutionTag.new(tag_params)
    if @tag.save
      respond_with @tag
    else
      p @tag.errors
      return not_saved
    end
  end

  def show
    respond_with @tag
  end

  def update
    if @tag.update(tag_params)
      respond_with @tag
    else
      p @tag.errors
      return not_saved
    end
  end

  def destroy
    @tag.destroy
    render json: { message: 'Institution Tag deleted' }, status: 200
  end

  def index
    @tags = InstitutionTag.all
  end

  private

  def set_tag
    @tag = InstitutionTag.find(params[:id])
    return not_found unless @tag
  end

  def tag_params
    params[:institution_tag].permit(
      :short_label,
      :long_label,
      :institution_tag_category_id,
      :status
    )
  end
end
