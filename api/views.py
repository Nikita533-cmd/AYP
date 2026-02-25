from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
import json
from datetime import datetime
from management_node.models import ControlUnit
from tubes.models import TubeType
from django.http import JsonResponse

from .solve import JsonBranchesViewer
from .Generat_equation import HydraulicParser

@csrf_exempt
def solve(request):
    data = json.loads(request.body)
    solveer = HydraulicParser(data).run_fsolve()
    print(f"📦 Данные: {solveer}")
    print(f"⏰ Время: {datetime.now()}")
    # t = JsonBranchesViewer(data).run()
    return JsonResponse({'data': data}) 
