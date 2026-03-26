from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
import json
from datetime import datetime
from django.http import JsonResponse

# from .solve import JsonBranchesViewer
# from .Generat_equation import HydraulicParser
name = ['length', 'height', 'count', 'count_branch', 'DN']
name2 = ['velocity', 'pressure_loss', 'flow_region', 'pressure', 'flow_sprinkler']

def branch():
    
    pass

def sole_api(request):
    data_new = {}
    data1 = {}
    if request.method == 'POST':
        data = request.POST
        count_branch = data['count_branch']
        print(count_branch)
        print(data)
        for key, value in data.lists():
            for i in name:
                if i in key:
                    data_new[key] = float(value[0])
        for key, value in data_new.items():
            for i in name2:
                key_new = key[0:4] + i
                data1[key_new] = value
        data_new.update(data1)
        return JsonResponse({'data': data_new})
    return JsonResponse({'error': 'Method not allowed'}, status=405)