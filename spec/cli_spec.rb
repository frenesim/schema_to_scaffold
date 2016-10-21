module SchemaToScaffold
  RSpec.describe CLI do

    let(:empty_schema_file) { File.expand_path(File.dirname(__FILE__)) + '/support/empty_schema.rb' }
    let(:schema_file) { File.expand_path(File.dirname(__FILE__)) + '/support/schema.rb' }

    describe ".start" do
      it "prints help message" do
        expect {
          begin
            SchemaToScaffold::CLI.start("-h")
          rescue SystemExit
          end
        }.to output(/Usage:/).to_stdout
      end

      it "prints file not found message" do
        expect {
          begin
            SchemaToScaffold::CLI.start("-p", "/support/schema.rb")
          rescue SystemExit
          end
        }.to output(/Unable to open file /).to_stdout
      end

      it "prints could not find tables message" do
        expect {
          begin
            SchemaToScaffold::CLI.start("-p", empty_schema_file)
          rescue SystemExit
          end
        }.to output(/Could not find tables /).to_stdout
      end

      context "choose table" do
        before do
          allow(STDIN).to receive(:gets) { "" }
        end

        it "prints Not a valid input message" do
          expect {
            begin
              SchemaToScaffold::CLI.start("-p", schema_file)
            rescue SystemExit
            end
          }.to output(/Not a valid input/).to_stdout
        end
      end

      context "choose all tables" do
        before do
          allow(STDIN).to receive(:gets).once { "*" }
        end

        it "prints scaffold lines message" do
          expect {
            begin
              SchemaToScaffold::CLI.start("-p", schema_file)
            rescue SystemExit
            end
          }.to output(/Script for/).to_stdout
        end
      end

      context "copies first table to clipboard" do
        before do
          allow(STDIN).to receive(:gets).once { "0" }
          expect_any_instance_of(Kernel).to receive(:exec).with("echo 'rails generate scaffold User email:string encrypted_password:string reset_password_token:string reset_password_sent_at:datetime remember_created_at:datetime sign_in_count:integer current_sign_in_at:datetime last_sign_in_at:datetime current_sign_in_ip:string last_sign_in_ip:string name:string role:integer --no-migration\n\n' | tr -d '\n' | pbcopy")
        end

        it "prints copied to your clipboard message" do
          expect {
            begin
              SchemaToScaffold::CLI.start("-c", "-p", schema_file)
            rescue SystemExit
            end
          }.to output(/copied to your clipboard/).to_stdout
        end
      end
    end
  end
end
