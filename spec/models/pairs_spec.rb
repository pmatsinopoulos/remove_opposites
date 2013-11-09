require 'spec_helper'

describe Pairs do
  describe "#add_origin_to_destination" do
    context 'given pairs is empty' do
      subject { Pairs.new({}) }
      it 'adds pair at start' do
        subject.add_origin_to_destination "A1", "B1"
        expect(subject.pairs).to eq({"A1" => ["B1"]})
      end
    end
    context 'given pairs is not empty' do
      context 'and has A1-B1' do
        before { @pairs = Pairs.new('A1' => ['B1']) }
        it 'does not add pair when given A1 B1' do
          expect do
            @pairs.add_origin_to_destination "A1", "B1"
          end.not_to change { @pairs.pairs.keys.size }
        end

        it 'does not add pair when given B1 A1' do
          expect do
            @pairs.add_origin_to_destination "B1", "A1"
          end.not_to change { @pairs.pairs.keys.size }
        end

        it 'adds pair when given A1 B2' do
          expect do
            @pairs.add_origin_to_destination "A1", "B2"
          end.to change { @pairs.pairs['A1'].size }.by(1)
        end

        it 'adds pair when given C1 D1' do
          expect do
            @pairs.add_origin_to_destination "C1", "D1"
          end.to change { @pairs.pairs.keys.size }.by(1)
          expect(@pairs.pairs['C1']).to eq(['D1'])
        end
      end
    end
  end
end