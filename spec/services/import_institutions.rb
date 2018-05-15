require 'rails_helper'

describe ImportInstitutions do


  let(:csv_file) { File.new(fixture_path + '/institutions.csv') }
  let(:wrong_csv_file) { File.new(fixture_path + '/institutions.csv') }
  subject { described_class.new(csv_file) }

  before(:each) do
    create(:code_category, title: 'uai')
  end

  describe 'initialize' do
    it 'assigns the instance variables correctly' do
      expect(subject.instance_variable_get(:@file)).to_not be_nil
      expect(subject.instance_variable_get(:@code_uai)).to_not be_nil
    end
  end

  describe '#call' do
    context 'when CSV file is valid' do
      context 'when 2 new institutions' do
        it 'creates 2 new institutions' do
          create(:institution, :with_code_uai)
          Code.last.update(content: 'Uxxx111xxp')

          expect(subject.call).to be_truthy
          expect(Institution.count).to eq(3)
        end
      end

      context 'when one new institutions, one same uai code' do
        it 'creates one new institution' do
          create(:institution, :with_code_uai)
          Code.last.update(content: 'Uxxx111xxx')

          expect(subject.call).to be_truthy
          expect(Institution.count).to eq(2)
        end
      end
    end

    context 'when CSV file is invalid' do
      it 'does not create institution' do
        expect(described_class.new(wrong_csv_file).call).to be_truthy
        expect(Institution.count).to eq(0)
      end
    end
  end
end
