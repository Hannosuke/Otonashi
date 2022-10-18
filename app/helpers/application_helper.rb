module ApplicationHelper
  def turbo_stream_flash
    turbo_stream.append "flashes", partial: "layouts/flash"
  end
end
