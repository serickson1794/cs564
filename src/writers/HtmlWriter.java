package writers;

import java.io.IOException;
import javax.servlet.jsp.JspWriter;

public class HtmlWriter {
	private JspWriter jspWriter;
	
	public HtmlWriter(JspWriter jspWriter) {
		this.jspWriter = jspWriter;
	}
	
	public void printOpenTag(String tag) throws IOException {
		try {
			jspWriter.println("<" + tag + ">");
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printOpenTag(String tag, String tagClass) throws IOException {
		try {
			String str = "<" + tag;
			str += tagAttribute("class", tagClass);
			str += ">";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printOpenTag(String tag, String tagClass, String style) throws IOException {
		try {
			String str = "<" + tag;
			str += tagAttribute("class", tagClass);
			str += tagAttribute("style", style);
			str += ">";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printCloseTag(String tag) throws IOException {
		try {
			jspWriter.println("</" + tag + ">");
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printOpenLink(String href) throws IOException {
		try {
			String str = "<a";
			str += tagAttribute("href", href);
			str += ">";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printOpenLink(String linkClass, String href) throws IOException {
		try {
			String str = "<a";
			str += tagAttribute("class", linkClass);
			str += tagAttribute("href", href);
			str += ">";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printCloseLink() throws IOException {
		try {
			jspWriter.println("</a>");
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printImage(String src, String width, String height) throws IOException {
		try {
			String str = "<img ";
			str += tagAttribute("src", src);
			str += tagAttribute("width", width);
			str += tagAttribute("height", height);
			str += " />";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printBreak() throws IOException {
		try {
			jspWriter.println("<br />");
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void print(String text) throws IOException {
		try {
			jspWriter.print(text);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void println(String text) throws IOException {
		try {
			jspWriter.println(text);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	private String tagAttribute(String name, String value) {
		return " " + name + "=\"" + value + "\"";
	}
}
