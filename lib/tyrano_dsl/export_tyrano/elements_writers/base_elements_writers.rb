require_relative 'elements_writers'

class TyranoDsl::ExportTyrano::ElementsWriters::BaseElementsWriters

  protected

  # @param [Array<String>] pathes
  def preload_text(pathes)
    pathes.collect {|a| "[preload storage=\"./#{a}\"]\n"}.join + '[return]'
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def log
    logger.info(self.class) {yield}
  end

end
