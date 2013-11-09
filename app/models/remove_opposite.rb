class RemoveOpposite
  include ActiveAttr::Model

  attribute :input_list
  attribute :output_list

  validates :input_list, :presence => true

  def process
    return false unless valid?
    generate
  end  

  private

  def generate
    pairs = Pairs.new({})
    input_list.split("\n").each do |line|
      line = line.strip
      parts = line.split("-")
      origin = parts[0].strip      if parts.size >= 1
      destination = parts[1].strip if parts.size >= 2
      next if origin.blank? || destination.blank?
      pairs.add_origin_to_destination(origin, destination)
    end
    self.output_list = build_output_list(pairs)
  end

  private

  def build_output_list (pairs)
    result = []
    pairs.pairs.each do |origin, destinations|
      destinations.each do |destination|
        result << "#{origin}-#{destination}"
      end unless destinations.blank?
    end unless pairs.blank? || pairs.pairs.blank?
    result.join("\n")
  end
end
