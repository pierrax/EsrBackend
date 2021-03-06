class Api::InstitutionTaggingsController < Api::BaseController
  before_action :set_institution, except: [:update, :import, :export]

  swagger_controller :tagging, 'Evolutions des taggings'

  swagger_api :import do
    summary 'Import taggings with CSV file'
    notes 'Créer / MAJ des taggings'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  swagger_api :export do
    summary 'Export taggings with CSV file'
    notes 'Créer / MAJ des taggings'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
  end
  
  def index
    @taggings = @institution.institution_taggings.ordered_by_category
  end

  def create
    @tag = InstitutionTag.find(params[:tag_id])
    @tags = @institution.tags
    return api_error(status: 302, errors: 'Error: Tag already added') if @tags.include?(@tag)

    @tagging = @institution.institution_taggings.build(tagging_params)
    @tagging.institution_tag_id = @tag.id
    @tagging.save!
    respond_with @tagging
  end

  def update
    @tagging = InstitutionTagging.find(params[:id])
    @tagging.update!(tagging_params)
    respond_with @tagging
  end

  def delete
    @tag = InstitutionTag.find(params[:tag_id])
    @tags = @institution.tags
    return api_error(status: 302, errors: "Error: Can't remove this tag" ) unless @tags.include?(@tag)

    @institution.tags.delete(@tag)
    render json: { message: 'Tag removed from institution' }, status: 200
  end

  def import
    import_response = ImportTaggings.new(params[:file].tempfile).call
    if import_response == true
      render json: { message: 'Taggings uploaded' }, status: 200
    else
      render json: { message: import_response }, status: 401
    end
  end

  def export
    @taggings = InstitutionTagging.all
    export_csv = ExportTaggings.new(@taggings).call
    send_data export_csv, type: 'text/csv', disposition: 'inline'
  end

  private

  def set_institution
    @institution = Institution.find(params[:institution_id])
  end

  def set_tag
    @tag = InstitutionTag.find(params[:id])
    return not_found unless @tag
  end

  def tagging_params
    params[:institution_tagging].permit(
        :institution_id,
        :institution_tag_id,
        :date_start,
        :date_end,
        :status
    )
  end
end
