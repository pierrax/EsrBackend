class Api::InstitutionConnectionsController < Api::BaseController

  swagger_controller :connections, 'Connections des établissements'

  swagger_api :create_mother do
    summary 'Create a mother'
    notes 'Créer une connection mère pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :body, :mother, :integer, :json, 'mother_id institution_connection_category_id date'
  end

  swagger_api :index_mothers do
    summary 'Returns all mothers for an institution'
    notes 'Tous les établissements mère pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :destroy_mother do
    summary 'Delete a mother connection'
    notes 'Effacer une connection mère'
    param :query, :link_id, :integer, :required, 'link ID'
    param :query, :mother_id, :integer, :required, 'mother ID'
  end

  swagger_api :create_daughter do
    summary 'Create a daughter'
    notes 'Créer une connection fille pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :body, :daughter, :integer, :json, 'daughter_id institution_connection_category_id date'
  end

  swagger_api :index_daughters do
    summary 'Returns all daughters for an institution'
    notes 'Tous les établissements fille pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :destroy_daughter do
    summary 'Delete a daughter connection'
    notes 'Effacer une connection fille'
    param :query, :link_id, :integer, :required, 'link ID'
    param :query, :daughter_id, :integer, :required, 'daughter ID'
  end

  swagger_api :import do
    summary 'Import connections with CSV file'
    notes 'Créer / MAJ des connections'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  swagger_api :export do
    summary 'Export connections with CSV file'
    notes 'Créer / MAJ des connections'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
  end

  def create_mother
    @institution = Institution.find(params[:institution_id])
    @connection = InstitutionConnection.new(mother_params)
    if @connection.save
      @connections = @institution.mother_connections
    else
      p @connection.errors
      return not_saved
    end
  end

  def index_mothers
    @institution = Institution.find(params[:institution_id])
    @mothers = @institution.mothers
    @connections = @institution.mother_connections
  end

  def destroy_mother
    @connection = InstitutionConnection.where(daughter_id: params[:institution_id], mother_id: params[:mother_id]).first
    return not_found unless @connection.present?
    @connection.destroy
    render json: { message: 'mother deleted' }, status: 200
  end

  def create_daughter
    @institution = Institution.find(params[:institution_id])
    @connection = InstitutionConnection.new(daughter_params)

    if @connection.save
      @connections = @institution.daughter_connections
    else
      p @connection.errors
      return not_saved
    end
  end

  def index_daughters
    @institution = Institution.find(params[:institution_id])
    @daughters = @institution.daughters
    @connections = @institution.daughter_connections
  end

  def destroy_daughter
    @connection = InstitutionConnection.where(mother_id: params[:institution_id], daughter_id: params[:daughter_id]).first
    return not_found unless @connection
    @connection.destroy
    render json: { message: 'daughter deleted' }, status: 200
  end

  def import
    if ImportConnections.new(params[:file].tempfile).call
      render json: { message: 'Connections uploaded' }, status: 200
    else
      render json: { message: 'Error with the file uploaded' }, status: 401
    end
  end

  def export
    @connections = InstitutionConnection.all
    export_csv = ExportConnections.new(@connections).call
    send_data export_csv, type: 'text/csv', disposition: 'inline'
  end

  private

  def mother_params
    params[:mother].permit(
        :mother_id,
        :institution_connection_category_id,
        :date
    ).merge(daughter_id: params[:institution_id])
  end

  def daughter_params
    params[:daughter].permit(
        :daughter_id,
        :institution_connection_category_id,
        :date
    ).merge(mother_id: params[:institution_id])
  end
end
