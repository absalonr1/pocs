import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.io.image.*;


public class App {
    public static void main(String[] args) throws Exception {


        PdfDocument pdf = new PdfDocument(new PdfWriter("/home/absalon/oci_rch_ass.pdf"));
        Document document = new Document(pdf);
        //String line = "Hello! Welcome to iTextPdf";
        //document.add(new Paragraph(line));

        for(int i=1; i < 502 ; i++){
            ImageData imageData = ImageDataFactory.create("/home/absalon/oci-pdfs/"+i+".jpg");
            Image pdfImg = new Image(imageData);
        
            document.add(pdfImg);

        }
        
        document.close();

        System.out.println("Awesome PDF just got created.");
    }
}
