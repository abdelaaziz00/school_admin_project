from reportlab.lib.pagesizes import letter
from reportlab.lib import colors
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Spacer, Image
import mysql.connector

def create_header():
    # Create a list for the images (left and right)
    image_left = r"C:\Users\HP\Desktop\school_admin_project\app\images\ibenzouherlogo.webp"  # Replace with your left image path
    image_right = r"C:\Users\HP\Desktop\school_admin_project\app\images\images.jpeg"  # Replace with your right image path
    
    # Create a Table for the header with images on left and right
    header_data = [
        [Image(image_left, width=100, height=100), "", Image(image_right, width=200, height=100)],
    ]
    
    # Use the full width of the page for the header (no empty space)
    header_table = Table(header_data, colWidths=[100, 300, 200])  # Adjust colWidths to fill page width
    header_style = TableStyle([ 
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('ALIGN', (0, 1), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTSIZE', (0, 0), (-1, -1), 12),
        ('BOX', (0, 0), (-1, -1), 1.5, colors.black),
    ])
    header_table.setStyle(header_style)
    
    return header_table

# Establish connection to the database
db_connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="pythone_pro"
)

cursor = db_connection.cursor()

# Define the student_id for filtering
student_id = "S123456789"

# Corrected query with explicit joins
query = """
SELECT 
    m.module_name,          
    s.subject_name,         
    ss.controle,            
    ss.final_exam,         
    ss.tp,  
    st.name                  
FROM 
    module m
JOIN subject s ON s.module_id = m.module_id
JOIN student_subject_information ss ON ss.subject_id = s.subject_id
JOIN student st ON ss.student_id = st.student_id
WHERE 
    st.student_id = %s;
"""

cursor.execute(query, (student_id,))

# Fetch all results
results = cursor.fetchall()

# Process the results
module_data = []
for row in results:
    module_name = row[0]
    subject_name = row[1]
    controle = row[2]
    final_exam = row[3]
    tp = row[4]
    student_name = row[5]
    
    
    note_finale = (controle + final_exam + tp) / 3
    note_finale = round(note_finale, 2)
    
    module_exists = False
    for module in module_data:
        if module["module_name"] == module_name:
            module_exists = True
            module["elements"].append([subject_name, controle, final_exam, tp, note_finale])
            break
    
    if not module_exists:
        module_data.append({
            "module_name": module_name,
            "elements": [
                [subject_name, controle, final_exam, tp, note_finale]
            ]
        })

# Function to create student information section in the PDF
def student_information(student_name, student_id):
    header_data = [
        ["Student Name:", student_name],
        ["Student ID:", student_id],
    ]
    
    header_table = Table(header_data, colWidths=[100, 200, 100])
    header_style = TableStyle([
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('TEXTCOLOR', (0, 0), (-1, -1), colors.black),
        ('ALIGN', (0, 1), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, -1), 12),
        ('BOX', (0, 0), (-1, -1), 1.5, colors.black),
    ])
    header_table.setStyle(header_style)
    
    return header_table

# Function to create module table
def create_module_table(module_name, module_note, element_data):
    module_header = [[module_name, "Note: " + module_note]]
    module_header_table = Table(module_header, colWidths=[180, 340])
    module_header_style = TableStyle([ 
        ('BACKGROUND', (0, 0), (-1, -1), colors.lightblue),
        ('TEXTCOLOR', (0, 0), (-1, -1), colors.black),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, -1), 12),
        ('BOX', (0, 0), (-1, -1), 1.5, colors.black),
    ])
    module_header_table.setStyle(module_header_style)

    inner_colWidths = [120, 80, 80, 80, 80]
    inner_ts = TableStyle([ 
        ('INNERGRID', (0, 0), (-1, -1), 0.5, colors.grey),
        ('BOX', (0, 0), (-1, -1), 1, colors.black),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('BACKGROUND', (0, 0), (-1, 0), colors.darkblue),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('BACKGROUND', (0, 1), (-1, -1), colors.whitesmoke),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.whitesmoke, colors.lightgrey]),
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 10),
        ('LEFTPADDING', (0, 0), (-1, -1), 6),
        ('RIGHTPADDING', (0, 0), (-1, -1), 6),
        ('TOPPADDING', (0, 0), (-1, -1), 4),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 4),
    ])
    element_table = Table(element_data, colWidths=inner_colWidths)
    element_table.setStyle(inner_ts)

    module_table = Table([[module_header_table], [element_table]])
    module_table_style = TableStyle([
        ('BOX', (0, 0), (-1, -1), 1.5, colors.black),
    ])
    module_table.setStyle(module_table_style)
    
    return module_table

# Define the PDF file name
fileName = 'school_admin_project_header.pdf'
pdf = SimpleDocTemplate(fileName, pagesize=letter, topMargin=0, bottomMargin=0, leftMargin=35, rightMargin=35)

# Create a list to hold all content
content = []

# Add the header (student info with images) to the content
content.append(Spacer(1, 10))
content.append(create_header())  # Add the header at the top without extra space
content.append(Spacer(1, 35))
content.append(student_information(student_name, student_id))  # Add student info right after the header

content.append(Spacer(1, 20))

# Generate the tables for each module
for module in module_data:
    note_module = round(sum([element[4] for element in module["elements"]]) / len(module["elements"]), 2)
    module_table = create_module_table(module["module_name"], str(note_module) + "/20", [["Subject Name", "Controle", "Final Exam", "TP", "Note Finale","resultat"]] + module["elements"])
    content.append(Spacer(1, 10))
    content.append(module_table)

# Build the PDF with all content
pdf.build(content)
