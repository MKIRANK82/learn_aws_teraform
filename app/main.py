from fastapi import FastAPI
from pydantic import BaseModel

from app.s3_repository import get_employees, save_employees

app = FastAPI()

# Testing a commit
class Employee(BaseModel):
    employee_id: int
    name: str
    department: str
    salary: float


@app.get("/")
def root():
    return {"message": "Employee API is running"}


@app.get("/employees")
def list_employees():
    return get_employees()


@app.post("/employees")
def create_employee(employee: Employee):
    employees = get_employees()

    employees.append(employee.model_dump())

    save_employees(employees)

    return employee