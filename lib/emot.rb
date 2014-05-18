require "emot/version"
require "emot/map"
require "emot/symbol_ext"
require "emot/cli"

module Emot
  def icon(name)
    if codes = MAP[name.intern]
      build_icon(codes)
    else
      nil
    end
  end
  alias :emoji :icon

  def unicode(name)
    if codes = MAP[name.intern]
      build_unicode(codes)
    else
      nil
    end
  end

  def list
    MAP.map do |name, codes|
      [name, [build_icon(codes), build_unicode(codes)]]
    end.sort_by(&:last).to_h
  end

  private
  def build_icon(codes)
    codes.map { |code| code.to_i(16) }.pack("U*")
  end

  def build_unicode(codes)
    codes.map { |code| "U+#{code}" }.join(" ")
  end

  extend self
end