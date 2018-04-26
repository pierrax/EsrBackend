class Api::InstitutionTaggingsController < Api::BaseController
  before_action :set_institution, except: :update

  def index
    @tags = @institution.tags
  end

  def create
    @tag = InstitutionTag.find(params[:tag_id])
    @tags = @institution.tags
    return api_error(status: 302, errors: 'Error: Tag already added') if @tags.include?(@tag)

    @tagging = @institution.institution_taggings.build(tagging_params)
    @tagging.institution_tag_id = @tag.id
    if @tagging.save

    else
      p @tagging.errors
      return api_error(status: 302, errors: "Error: Can't add this tag" )
    end
  end

  def update
    @tagging = InstitutionTagging.find(params[:id])

    if @tagging.update(tagging_params)

    else
      p @tagging.errors
      return api_error(status: 302, errors: "Error: Can't modify this tagging" )
    end
  end

  def delete
    @tag = InstitutionTag.find(params[:tag_id])
    @tags = @institution.tags
    return api_error(status: 302, errors: "Error: Can't remove this tag" ) unless @tags.include?(@tag)

    @institution.tags.delete(@tag)
    render json: { message: 'Tag removed from institution' }, status: 200
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
