package writers;

import java.io.IOException;
import java.util.Calendar;

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
	
	public void printLinkDiv(String divClass, String onClickUrl) throws IOException {
		try {
			String str = "<div";
			str += tagAttribute("class", divClass + " linkDiv");
			str += tagAttribute("onclick", "window.location = '" + onClickUrl + "'");
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
			String str = "<img";
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
	
	public void printOpenForm(String action) throws IOException {
		try {
			String str = "<form";
			str += tagAttribute("method", "POST");
			str += tagAttribute("action", action);
			str += ">";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printRadio(String id, String name, String value, String checked) throws IOException {
		try {
			String str = "<input";
			str += tagAttribute("type", "radio");
			str += tagAttribute("id", id);
			str += tagAttribute("name", name);
			str += tagAttribute("value", value);
			if(checked == "checked") str += tagAttribute("checked", checked);
			str += " />";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printOpenLabel(String forInput) throws IOException {
		try {
			String str = "<label";
			str += tagAttribute("for", forInput);
			str += ">";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printOpenTextArea(String textAreaClass, String name, String placeholder) throws IOException {
		try {
			String str = "<textarea";
			str += tagAttribute("class", textAreaClass);
			str += tagAttribute("name", name);
			str += tagAttribute("placeholder", placeholder);
		    str += ">";
		    jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printSubmit(String name, String value, boolean enabled) throws IOException {
		try {
			String str = "<input";
			str += tagAttribute("type", "submit");
			str += tagAttribute("name", name);
			str += tagAttribute("value", value);
			if (!enabled) str += tagAttribute("disabled", "disabled");
			str += " />";
			jspWriter.println(str);
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printStars(Double stars) throws IOException {
		try {
			int scale = 10;
			while (stars > 0) {
				stars = (double) Math.round(stars * scale) / scale;
				if (stars <= 0.2) {

				} else if (stars <= 0.7) {
					printImage("images/halfstar.jpg", "20px", "20px");
				} else {
					printImage("images/star.jpg", "20px", "20px");
				}
				stars = stars - 1.0;
			}
		} catch (IOException ioe) {
			throw ioe;
		}
	}
	
	public void printDate(String dateStr) throws IOException {
		try {
			int spaceIndex = dateStr.indexOf(' ');
			String date = dateStr.substring(0, spaceIndex);
			int dashIndex1 = date.indexOf('-');
			int dashIndex2 = date.indexOf('-', dashIndex1 + 1);
			String month = date.substring(dashIndex1 + 1, dashIndex2);
			String day = date.substring(dashIndex2 + 1, date.length());
			String year = date.substring(0, dashIndex1);
			jspWriter.println(month + "/" + day + "/" + year);
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
