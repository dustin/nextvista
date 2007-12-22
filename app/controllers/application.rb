# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  DEFAULT_TITLE='Next Vista for Learning'

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_nextvista_session_id'

  def initialize
    @page_title=DEFAULT_TITLE
  end

  # Set the title for a given page.
  def title(str)
    @page_title=str
  end

  # Set a subtitle  (keeping the default title)
  def subtitle(str)
    title "#{DEFAULT_TITLE} - #{str}"
  end

  protected  

  def log_error(exception) 
    super(exception)

    begin
      ErrorMailer.deliver_snapshot(
        exception, 
        clean_backtrace(exception), 
        @session.instance_variable_get("@data"), 
        @params, 
        @request.env)
    rescue => e
      logger.error(e)
    end
  end

end
