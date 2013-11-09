require 'spec_helper'

describe RemoveOpposite do
  describe "#process" do
    context 'when valid' do
      before do
        allow(subject).to receive(:valid?).and_return(true)
      end
      it 'calls generate' do
        result = double('result')

        expect(subject).to receive(:generate).and_return(result)

        expect(subject.process).to eq(result)
      end
    end

    context 'when not valid' do
      before do
        allow(subject).to receive(:valid?).and_return(false)
      end
      it 'does not call generate' do
        expect(subject).not_to receive(:generate)
        expect(subject.process).to be_false
      end
    end
  end

  describe "#generate" do
    context 'given a list A' do
      before do
        @input_list =<<-INPUTLIST
          A1-B1
          A2-B2
          A3-B3
          A2-B4
          B2-A2
          A3-B4
          B3-A3
        INPUTLIST
        @remove_opposite = RemoveOpposite.new :input_list => @input_list
      end
      it 'generates the correct output' do
        @remove_opposite.send :generate
        output = "A1-B1\nA2-B2\nA2-B4\nA3-B3\nA3-B4"
        expect(@remove_opposite.output_list).to eq(output)
      end
    end
  end

  describe "#build_output_list" do
    context 'given a list A of pairs' do
      before do
        @pairs = Pairs.new({'A1' => ['B1A1', 'B2A1'], 'A2' => ['B1A2'], 'A3' => ['B1A3', 'B2A3', 'B3A3']})
      end
      it 'produces the correct output' do
        result = subject.send :build_output_list, @pairs
        expect(result).to eq(["A1-B1A1", "A1-B2A1", "A2-B1A2", "A3-B1A3", "A3-B2A3", "A3-B3A3"].join("\n"))
      end
    end

    context 'given a blank list of pairs' do
      before do
        @pairs = Pairs.new(nil)
      end
      it 'produces the correct output' do
        result = subject.send :build_output_list, @pairs
        expect(result).to eq([].join("\n"))
      end
    end

    context 'given a list B of pairs that has blank destinations' do
      before do
        @pairs = Pairs.new({'A1' => ['B1A1', 'B2A1'], 'A2' => nil, 'A3' => ['B1A3', 'B2A3', 'B3A3']})
      end
      it 'produces the correct output' do
        result = subject.send :build_output_list, @pairs
        expect(result).to eq(["A1-B1A1", "A1-B2A1", "A3-B1A3", "A3-B2A3", "A3-B3A3"].join("\n"))
      end
    end

  end
end
