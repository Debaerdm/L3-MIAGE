package dom;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

public class parserDom {
	public static void main(String[] args) {
		DocumentBuilderFactory documentParser = DocumentBuilderFactory.newInstance();
		documentParser.setIgnoringElementContentWhitespace(true);
		//documentParser.setValidating(true);
		try {
			DocumentBuilder builder = documentParser.newDocumentBuilder();
			builder.setErrorHandler(new ErrorHandler() {
				
				@Override
				public void warning(SAXParseException exception) throws SAXException {
					System.out.println("Warning");
					exception.printStackTrace();
				}
				
				@Override
				public void fatalError(SAXParseException exception) throws SAXException {
					System.out.println("Fatal Error");
					exception.printStackTrace();
				}
				
				@Override
				public void error(SAXParseException exception) throws SAXException {
					System.out.println("Error");
					exception.printStackTrace();
				}
			});
			Document document = builder.parse(new File("expbis.xml"));
			
			Element parent = (Element) document.getDocumentElement().getFirstChild();
			addElementConstantes(document, parent);
			
			XMLTOOLS1.ecrireXML(document, "expbisbis.xml", "expMath.dtd");
		} catch (ParserConfigurationException | SAXException | IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void addElementConstantes(Document document, Element parent) {
		Element cons = document.createElement("const");
		cons.setAttribute("nom", "X");
		cons.setAttribute("valeur", "1");
		parent.appendChild(cons);
	}
}
