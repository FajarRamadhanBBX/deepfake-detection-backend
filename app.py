from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
import numpy as np
from tensorflow.keras.applications.mobilenet_v2 import preprocess_input
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image
import io
from PIL import Image

app = FastAPI()

MODEL_PATH = "model/model_mobilenetv2.h5"
try:
    model = load_model(MODEL_PATH)
except Exception as e:
    model = None
    print(f"Failed to load model: {e}")

def preprocess_image(img_bytes):
    img = Image.open(io.BytesIO(img_bytes)).convert('RGB')
    img = img.resize((224, 224))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = preprocess_input(img_array)
    return img_array

@app.get("/")
async def root():
    return {"message": "Hello World, this is my first time use github actions, test CI/CD pipeline!"}

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    if model is None:
        raise HTTPException(status_code=500, detail="Model not loaded.")
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File is not an image.")
    try:
        contents = await file.read()
        img_array = preprocess_image(contents)
        preds = model.predict(img_array)
        pred_class = int(np.round(preds[0][0]))
        label = "fake" if pred_class == 1 else "real"
        confidence = float(preds[0][0]) if pred_class == 1 else 1 - float(preds[0][0])
        return JSONResponse({"label": label, "confidence": confidence})
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction failed: {e}")
