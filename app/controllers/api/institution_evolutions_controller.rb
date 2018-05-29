class Api::InstitutionEvolutionsController < Api::BaseController

  swagger_controller :connections, 'Evolutions des établissements'

  swagger_api :create_predecessor do
    summary 'Create a predecessor'
    notes 'Créer une évolution prédécesseur pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :body, :predecessor, :integer, :json, 'predecessor_id institution_evolution_category_id date'
  end

  swagger_api :index_predecessors do
    summary 'Returns all predecessors for an institution'
    notes 'Tous les établissements prédécesseur pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :destroy_predecessor do
    summary 'Delete a predecessor connection'
    notes 'Effacer une évolution prédécesseur'
    param :query, :institution_id, :integer, :required, 'Institution ID'
    param :query, :predecessor_id, :integer, :required, 'predecessor ID'
  end

  swagger_api :create_follower do
    summary 'Create a follower'
    notes 'Créer une évolution suiveur pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :body, :follower, :integer, :json, 'follower_id institution_connection_category_id date'
  end

  swagger_api :index_followers do
    summary 'Returns all followers for an institution'
    notes 'Tous les évolutions suiveur pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :destroy_follower do
    summary 'Delete a follower connection'
    notes 'Effacer une évolution suiveur'
    param :query, :institution_id, :integer, :required, 'Institution ID'
    param :query, :follower_id, :integer, :required, 'follower ID'
  end

  swagger_api :import do
    summary 'Import evolutions with CSV file'
    notes 'Créer / MAJ des evolutions'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  swagger_api :export do
    summary 'Export evolutions with CSV file'
    notes 'Créer / MAJ des evolutions'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
  end
  
  def create_predecessor
    @institution = Institution.find(params[:institution_id])
    @evolution = InstitutionEvolution.create!(predecessor_params)
    respond_with @evolution
  end

  def index_predecessors
    @institution = Institution.find(params[:institution_id])
    @predecessors = @institution.predecessors
    @evolutions = @institution.predecessor_evolutions
  end

  def destroy_predecessor
    @evolution = InstitutionEvolution.where(follower_id: params[:institution_id], predecessor_id: params[:predecessor_id]).first
    return not_found unless @evolution.present?
    @evolution.destroy
    render json: { message: 'Predecessor deleted' }, status: 200
  end

  def create_follower
    @institution = Institution.find(params[:institution_id])
    @evolution = InstitutionEvolution.create!(follower_params)
    respond_with @evolution
  end

  def index_followers
    @institution = Institution.find(params[:institution_id])
    @followers = @institution.followers
    @evolutions = @institution.follower_evolutions
  end

  def destroy_follower
    @evolution = InstitutionEvolution.where(predecessor_id: params[:institution_id], follower_id: params[:follower_id]).first
    return not_found unless @evolution
    @evolution.destroy
    render json: { message: 'Follower deleted' }, status: 200
  end

  def import
    if ImportEvolutions.new(params[:file].tempfile).call
      render json: { message: 'Evolutions uploaded' }, status: 200
    else
      render json: { message: 'Error with the file uploaded' }, status: 401
    end
  end

  def export
    @evolutions = InstitutionEvolution.all
    export_csv = ExportEvolutions.new(@evolutions).call
    send_data export_csv, type: 'text/csv', disposition: 'inline'
  end

  private

  def predecessor_params
    params[:predecessor].permit(
        :predecessor_id,
        :institution_evolution_category_id,
        :date
    ).merge(follower_id: params[:institution_id])
  end

  def follower_params
    params[:follower].permit(
        :follower_id,
        :institution_evolution_category_id,
        :date
    ).merge(predecessor_id: params[:institution_id])
  end
end
