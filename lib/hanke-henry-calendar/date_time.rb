require File.join(File.dirname(__FILE__), 'hanke_henry_date')

class DateTime
  extend HankeHenryDate::Module
  include HankeHenryDate
  
  def self._hh_arg_limit
    8
  end
end
