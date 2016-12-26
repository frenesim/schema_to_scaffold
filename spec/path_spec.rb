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
        let(:invalid_path) { Path.new(File.expand_path(File.dirname(__FILE__)) + '/support/no_path') }
        before do
          allow(STDIN).to receive(:gets) { "0" }
        end

        it "prints message when given path is a directory" do
          expect {
            path.choose
          }.to output(/Select a path to the target schema/).to_stdout
        end
        it "prints an error message when given path is not a directory" do
          expect {
            invalid_path.choose
          }.to output(/Select a pathsdfsdf to the target schema/).to_stdout
        end
      end

      it "prints message when given path is an directory but no schema is found" do
        path = Path.new(File.expand_path(File.dirname(__FILE__)) + '/support/no_schema')
        allow_any_instance_of(Path).to receive(:check_directory).and_return(true)
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
