require File.join(File.dirname(__FILE__), 'hanke_henry_date')

class Date
  extend HankeHenryDate::Module
  include HankeHenryDate
  
  private
  def self._hh_arg_limit
    4
  end
end
