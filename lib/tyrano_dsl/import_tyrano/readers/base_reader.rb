require 'logger'

require_relative 'readers'

class TyranoDsl::ImportTyrano::Readers::BaseReader

  protected

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def log
    logger.info(self.class) {yield}
  end

end
