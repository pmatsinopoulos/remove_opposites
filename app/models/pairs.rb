class Pairs < Struct.new (:pairs)
  # @param origin [String]
  # @param destination [String]
  #
  #  adds "B1-A1" (origin-destination) only if the pair "A1-B1" does not exist, a.k.a. "B1" is not included in the list of destinations of "A1"
  def add_origin_to_destination (origin, destination)
    unless pairs[destination].present? && pairs[destination].include?(origin)
      pairs[origin] = [] if pairs[origin].blank?
      pairs[origin] << destination
    end
  end
end