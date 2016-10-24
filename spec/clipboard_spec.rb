module SchemaToScaffold
  RSpec.describe Clipboard do
    let(:output) { "rails g model ....." }
    let(:clipboard) { Clipboard.new(output) }

    describe "#command" do
      context "darwin" do
        before do
          allow(clipboard).to receive(:platform).and_return("darwin")
          expect_any_instance_of(Kernel).to receive(:exec).with("echo 'rails g model .....' | tr -d '\n' | pbcopy")
        end

        it "executes darwin command" do
          clipboard.command
        end
      end

      context "linux" do
        before do
          allow(clipboard).to receive(:platform).and_return("linux")
          expect_any_instance_of(Kernel).to receive(:exec).with("echo 'rails g model .....' | tr -d '\n' | xclip -selection c")
        end

        it "executes linux command" do
          clipboard.command
        end
      end

      context "windows (win)" do
        before do
          allow(clipboard).to receive(:platform).and_return("win")
          expect_any_instance_of(Kernel).to receive(:exec).with("echo 'rails g model .....' | clip")
        end

        it "executes windows command" do
          clipboard.command
        end
      end

      context "windows (mingw)" do
        before do
          allow(clipboard).to receive(:platform).and_return("mingw")
          expect_any_instance_of(Kernel).to receive(:exec).with("echo 'rails g model .....' | clip")
        end

        it "executes windows command" do
          clipboard.command
        end
      end
    end
  end
end
