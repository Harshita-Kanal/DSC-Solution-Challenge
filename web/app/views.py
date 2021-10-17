# -*- encoding: utf-8 -*-
import sys
import requests

sys.path.append('..')

from flask import render_template, request, session, url_for, redirect, jsonify
from jinja2 import TemplateNotFound
from connect_firebase import connect

from app import app

hosp_coll = connect('hospitals')
beds_coll = connect('beds')
requests_coll = connect('bed_requests')
req_data = {}
bed_docs_id = {}

@app.route('/', methods=['GET'])
def home():
    global req_data
    if session.get('email'):
        hosp_info = session.get('hosp_info', {})
        beds = session.get('beds', {})
        return render_template('index.html', hosp_info=hosp_info, beds=beds, req_data=req_data)
    else:
        return redirect('/login')

@app.route('/updating', methods=['POST'])
def dbchanges():
    global req_data
    data = request.get_json(force=True)
    if data:
        req_data[data['id']] = data['data']
    #TODO: Update data on index
    return jsonify({"status":"success"})

@app.route('/login', methods=['POST', 'GET'])
def login():
    global bed_docs_id
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        session['email'] = email
        query_ref = hosp_coll.where(u'Email', u'==', u'{}'.format(email)).stream()
        hosp_info = next(query_ref)
        session['hosp_id'] = hosp_info.id
        hosp_info = hosp_info.to_dict()
        beds = {}
        query_ref = beds_coll.where(u'Hospital', u'==', u'{}'.format(hosp_info.get('Hname'))).stream()
        for bed in query_ref:
            b = bed.to_dict()
            bid = bed.id
            btype = b.pop('Bed_Type')
            beds[btype] = b
            bed_docs_id[btype] = bid
        session['hosp_info'] = hosp_info
        session['beds'] = beds
        return redirect('/')
    if request.method == 'GET':
        return render_template('login.html')

@app.route('/logout', methods=['POST', 'GET'])
def logout():
    if session.get('email'):
        session.pop('email',None)
        session.pop('hosp_info', None)
        session.pop('hosp_id', None)
        session.pop('beds', None)
    return redirect('/login')

@app.route('/accept_bed_request', methods=['POST'])
def accept():
    global bed_docs_id
    data = request.form
    reqid = data.get('reqid')
    req_num = int(data.get('num_of_beds'))
    bed_type = data.get('type')
    beds = session['beds']
    beds_status = beds.get(bed_type)
    beds_avail = int(beds_status.get('Available'))
    new_beds_avail = beds_avail - req_num
    if new_beds_avail >= 0:
        requests_coll.document(u'{}'.format(reqid)).update({u'status':'Allotted'})
        beds_coll.document(u'{}'.format(bed_docs_id[bed_type])).update({u'Available': new_beds_avail})
        beds[bed_type]['Available'] = new_beds_avail
        session['beds'] = beds
    return redirect('/')

@app.route('/waitlist_bed_request', methods=['POST'])
def waitlist():
    data = request.form
    reqid = data.get('reqid')
    if reqid:
        requests_coll.document(u'{}'.format(reqid)).update({u'status':'Waitlisted'})
    return redirect('/')

@app.route('/reject_bed_request', methods=['POST'])
def reject():
    data = request.form
    reqid = data.get('reqid')
    if reqid:
        requests_coll.document(u'{}'.format(reqid)).update({u'status':'Rejected'})
    return redirect('/')
