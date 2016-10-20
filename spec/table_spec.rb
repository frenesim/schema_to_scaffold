module SchemaToScaffold
  RSpec.describe Table do

    let(:table_data) { File.read(File.expand_path(File.dirname(__FILE__)) + '/support/table.rb') }
    let(:email_attribute) { Attribute.new("email", "string") }
    let(:password_attribute) { Attribute.new("password", "string") }

    describe "#to_script" do
      let(:table) { Table.new("users", [email_attribute, password_attribute]) }

      it "returns rails generate line" do
        expect(table.to_script("model", true)).to eq(["rails generate model User email:string password:string", "\n\n"])
      end

      it "returns rails generate line without migrations" do
        expect(table.to_script("model", false)).to eq(["rails generate model User email:string password:string", " --no-migration", "\n\n"])
      end

      it "raises an exception" do
        allow(email_attribute).to receive(:to_script).and_raise(StandardError, "something went wrong")
        expect { table.to_script("model", true) }.to output(/something went wrong/).to_stdout
      end
    end

    describe ".parse" do
      let(:table) { Table.parse(table_data) }
      it "parses given table data" do
        expect(table).to be_kind_of(SchemaToScaffold::Table)
      end
    end

  end
end