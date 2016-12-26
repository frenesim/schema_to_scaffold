module SchemaToScaffold
  RSpec.describe Schema do

    let(:schema_data) { File.read(File.expand_path(File.dirname(__FILE__)) + '/support/schema.rb') }
    let(:schema) { Schema.new(schema_data) }

    describe ".parse" do
      it "parses given schema file" do
        expect(Schema.parse(schema_data)).to be_kind_of(Array)
      end
    end

    describe "#table_names" do
      it "returns table names" do
        expect(schema.table_names).to eq(["users"])
      end
    end

    describe "#to_script" do
      it "is broken" do
        pending
        expect(schema.to_script).to eq("users")
      end
    end

    describe "#table" do
      it "returns parsed table by given table name as symbol" do
        expect(schema.table(:users)).to be_kind_of(SchemaToScaffold::Table)
      end

      it "returns parsed table by given table index" do
        expect(schema.table(0)).to be_kind_of(SchemaToScaffold::Table)
      end

      it "returns nil" do
        expect(schema.table([])).to be_nil
      end

      it "returns nil" do
        pending
        expect(schema.table("")).to be_nil
      end
    end
  end
end
