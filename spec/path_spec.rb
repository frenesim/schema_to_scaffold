require'pry'
module SchemaToScaffold
  RSpec.describe Path do

    describe "#choose" do
      it "prints error when given path is not an directory" do
        path = Path.new("path_spec.rb")
        expect {
          begin
            path.choose
          rescue SystemExit
          end
        }.to output(/Sorry path_spec\.rb is not a valid directory!/).to_stdout
      end

      context "needs user input" do
        let(:path) { Path.new(File.expand_path(File.dirname(__FILE__)) + '/support') }
        before do
          allow(STDIN).to receive(:gets) { "0" }
        end

        it "prints message when given path is a directory" do
          expect {
            path.choose
          }.to output(/Select a path to the target schema/).to_stdout
        end
       end

      it "prints message when given path is a directory but no schema is found" do
        path = Path.new(File.expand_path(File.dirname(__FILE__)) + '/support/no_schema')
        expect {
          begin
            path.choose
          rescue SystemExit
          end
        }.to output(/There is no/).to_stdout
      end
    end
  end
end
