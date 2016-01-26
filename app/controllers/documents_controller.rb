class DocumentsController < ApplicationController
  def index
    @documents = Document.order('created_at')
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      flash[:success] = "The document was added!"
      redirect_to documents_path
    else
      render 'new'
    end
  end

  def show
    @document = Document.find(params[:id])
    @document.watermark_pdf
    watermark_pdf = @document.watermark_pdf
    pdf = CombinePDF.load @document.path
    watermark_pdf.pages.each_with_index do |page, index|
      page << pdf.pages[index]
    end
    @watermark_document = "tmp/tmp_#{@document.document_file_name}"
    watermark_pdf.save @watermark_document
    send_file(@watermark_document, disposition: 'inline', type: 'application/pdf', x_sendfile: true)
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    flash[:success] = "The document was destroyed."
    redirect_to documents_path
  end

  private

  def document_params
    params.require(:document).permit(:email, :document)
  end
end
