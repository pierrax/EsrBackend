class Api::CodesController < Api::BaseController
  before_action :set_code, except: %i[create index]

  swagger_controller :codes, 'Codes des établissements'

  swagger_api :create do
    summary 'Create a code'
    notes 'Crée un code pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :integer, :category_code_id, :integer, :required, 'Category code ID'
  end

  swagger_api :index do
    summary 'Returns all codes for an institution'
    notes 'Tous les codes pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :show do
    summary 'Show a code'
    notes 'Afficher un code'
    param :integer, :code_id, :integer, :required, 'code ID'
  end

  swagger_api :update do
    summary 'Update a code'
    notes 'Mettre à jour un code'
    param :integer, :code_id, :integer, :required, 'code ID'
  end

  swagger_api :destroy do
    summary 'Delete a code'
    notes 'Effacer un code'
    param :integer, :code_id, :integer, :required, 'code ID'
  end
  
  def create
    @institution = Institution.find(params[:institution_id])
    @code = @institution.codes.new(code_params)
    if @code.save
      @code
    else
      p @code.errors
      return not_saved
    end
  end

  def show
    respond_with @code
  end

  def update
    if @code.update(code_params)
      respond_with @code
    else
      return not_saved
    end
  end

  def destroy
    @code.destroy
    render json: { message: 'Code deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @codes = @institution.codes
  end

  private

  def set_code
    @code = Code.find(params[:id])
    return not_found unless @code
  end

  def code_params
    params[:code].permit(
        :content,
        :institution_id,
        :code_category_id,
        :date_start,
        :date_end,
        :status
    )
  end
end
