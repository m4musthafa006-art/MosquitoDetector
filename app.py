import streamlit as st
from ultralytics import YOLO
from PIL import Image
import tempfile

st.title("🦟 Mosquito Detector")

model = YOLO("best.pt")

uploaded_file = st.file_uploader(
    "Upload an image",
    type=["jpg", "jpeg", "png"]
)

if uploaded_file is not None:
    image = Image.open(uploaded_file)

    st.image(image, caption="Uploaded Image")

    with tempfile.NamedTemporaryFile(delete=False, suffix=".jpg") as tmp:
        image.save(tmp.name)

        results = model(tmp.name)

        annotated = results[0].plot()

        st.image(
            annotated,
            caption="Detection Result",
            use_container_width=True
        )

        count = len(results[0].boxes)

        st.success(f"Mosquitoes Detected: {count}")