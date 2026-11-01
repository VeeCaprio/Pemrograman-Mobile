from datetime import datetime
from zoneinfo import ZoneInfo

from fastapi import FastAPI, HTTPException
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError

from .database import engine

app = FastAPI(title="TabungKu API", version="0.1.0")


@app.get("/")
def beranda():
    return {
        "pesan": "Selamat datang di TabungKu API. Dokumentasi: /docs"
    }


@app.get("/health")
def health():
    try:
        with engine.connect() as connection:
            mysql_version = connection.execute(
                text("SELECT VERSION()")
            ).scalar_one()

        return {
            "status": "ok",
            "waktu_server": datetime.now().isoformat(timespec="seconds"),
            "database": "connected",
            "mysql_version": mysql_version,
        }

    except SQLAlchemyError as exc:
        raise HTTPException(
            status_code=503,
            detail={
                "status": "error",
                "database": "error",
                "detail": str(exc),
            },
        )


@app.get("/info")
def get_info():
    return {
        "app_name": "TabungKu Cloud",
        "version": "0.1.0",
        "timezone": "Asia/Jakarta",
        "server_time": datetime.now(
            ZoneInfo("Asia/Jakarta")
        ).isoformat(),
    }
