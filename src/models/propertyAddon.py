from pydantic import BaseModel

class PropertyAddon(BaseModel):
    propertyAddonId: int
    wifi: bool = False
    kitchen: bool = False
    parking: bool = False
    staffService: bool = False
    pool: bool = False
    securityCameras: bool = False
    laundry: bool = False
    gym: bool = False
