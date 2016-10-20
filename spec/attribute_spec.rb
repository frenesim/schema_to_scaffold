module SchemaToScaffold
  RSpec.describe Attribute do

    describe ".parse" do
      it "parses _id attribute to references" do
        attribute = Attribute.parse('t.integer  "user_id"')
        expect(attribute.type).to eq("references")
        expect(attribute.name).to eq("user")
      end

      it "parses string attributes" do
        attribute = Attribute.parse('t.string   "filename"')
        expect(attribute.type).to eq("string")
        expect(attribute.name).to eq("filename")
      end

      it "parses datetime attributes" do
        attribute = Attribute.parse('t.datetime "created_at", null: false')
        expect(attribute.type).to eq("datetime")
        expect(attribute.name).to eq("created_at")
      end

      it "parses limit value" do
        pending
        attribute = Attribute.parse('t.integer  "quota",  limit: 8')
        expect(attribute.type).to eq("integer")
        expect(attribute.name).to eq("quota")
        expect(attribute.limit).to eq("8")
      end

      it "parses decimals precision and scale values" do
        pending
        attribute = Attribute.parse('t.decimal  "price", precision: 20, scale: 2, default: 0.0')
        expect(attribute.type).to eq("decimal")
        expect(attribute.name).to eq("price")
        expect(attribute.precision).to eq("20")
        expect(attribute.scale).to eq("2")
      end
    end

    describe "#to_script" do
      it "returns name and type" do
        attribute = Attribute.parse('t.string   "filename"')
        expect(attribute.to_script).to eq("filename:string")
      end

      it "ignores updated_at" do
        attribute = Attribute.parse('t.datetime "updated_at", null: false')
        expect(attribute.to_script).to be_nil
      end

      it "ignores created_at" do
        attribute = Attribute.parse('t.datetime "created_at", null: false')
        expect(attribute.to_script).to be_nil
      end

      it "adds limit value to integer" do
        pending
        attribute = Attribute.parse('t.integer  "quota",  limit: 8')
        expect(attribute.to_script).to eq("quota:integer{8}")
      end

      it "adds precision and scale value to decimal" do
        pending
        attribute = Attribute.parse('t.decimal  "price", precision: 20, scale: 2, default: 0.0')
        expect(attribute.to_script).to eq("price:decimal{20,2}")
      end
    end
  end
end
