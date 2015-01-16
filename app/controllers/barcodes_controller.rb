require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'


class BarcodesController < ApplicationController
  def new

  end

  def listing
    # barcode array to handle > 1 amount of barcodes
    @barcodes = []
    # form from new variables data & amount
    @amount = params[:amount]
    @data = params[:data]
    #path to save barcodes
    full_path= "app/assets/images/barcodes/#{@data}.png"
    #barby processing code128B to png barcode
    barcode = Barby::Code128B.new(@data)
    barcode_image = Barby::PngOutputter.new(barcode).to_png
    #saving to full_path
    File.open(full_path, 'w') {|f| f.write barcode_image}
    #fill array with links to img to use in view
    @amount.to_i.times { @barcodes << "barcodes/#{@data}.png" }

  end
end
