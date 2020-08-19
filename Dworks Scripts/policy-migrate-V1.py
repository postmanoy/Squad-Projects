from __future__ import print_function
import sys, warnings
import deepsecurity
from deepsecurity.rest import ApiException
from pprint import pprint
import requests
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

print("Welcome to Cloud One - Workload Security Policy Migration Tool!")
print()
url_link = input("Please enter the URL of your DSM (if DSaaS, press ENTER): ")

tenant1key = input("Input Source Tenant API Key: ")
tenant2key = input("Input Destination Tenant API Key: ")

cert = False

antimalwareconfig = []
allofpolicy = []
directorylist = []
fileextentionlist = []
filelist = []
allamconfig = []
alldirectory = []
allfileextention = []
allfilelist = []
alldirectorynew = []
allfileextentionnew = []
allfilelistnew = []
allamconfignew = []
firewallruleid = []
allfirewallrule = []
allfirewallrulename = []
allfirewallruleidnew1 = []
allfirewallcustomrule = []
allfirewallruleidold = []
allfirewallruleidnew2 = []
ipsappid =[]
allipsapp = []
allipsappname = []
allipsappidnew1 = []
allipscustomapp = []
allipsappidold = []  
allipsappidnew2 = []
ipsruleid =[]
allipsrule = []
allipsrulename = [] 
allipsruleidnew1 = []
allipscustomrule = []
allipsruleidold = []
allipsruleidnew2 = []
liruleid = []
alllirule = []
alllirulename = []  
allliruleidnew1 = []
alllicustomrule = []
allliruleidold = []
allliruleidnew2 = []
imruleid =[]
allimrule = []
allimrulename = []
allimruleidnew1 = []
allimcustomrule = []
allimruleidold = []
allimruleidnew2 = []

if url_link != "":
    url_link_final = url_link
else:
    url_link_final = "https://app.deepsecurity.trendmicro.com/"

url_link_final_2 = "https://app.deepsecurity.trendmicro.com/"

def ListAllPolicyAPI():
    payload  = {}
    url = url_link_final + 'api/policies'
    headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
    }
    response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
    describe = str(response.text)
    #describe = describe[:-1]
    #describe = describe[2:]
    index = 0
    oldpolicyname = []
    oldpolicyid = []
    while index != -1:
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    oldpolicyname.append(str(indexid))
        index = describe.find('\"ID\"')
        if index != -1:
            indexpart = describe[index+4:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    oldpolicyid.append(str(indexid))
                    describe = indexpart[endIndex:]
                else:
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        oldpolicyid.append(str(indexid))
                        describe = indexpart[endIndex:]
        
                    
    print("List of your policy:")
    print()
    for count, here in enumerate(oldpolicyname):
        print("ID: "+ str(oldpolicyid[count]) + " || NAME: "+ here)
        print()

def GetPolicy(policyIDs):
    global antimalwareconfig
    i = 0
    print ("Getting Policy from Tenant 1")
    for part in policyIDs.split():
        
        payload  = {}
        url = url_link_final + 'api/policies/' + str(part)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        
        describe = str(response.text)
        i = i + 1
        allofpolicy.append(describe)
        print (str(part))


        rtscan = describe.find('realTimeScanConfigurationID')
        if rtscan != -1:
            rtpart = describe[rtscan+28:]
            startIndex = rtpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = rtpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    rtid = rtpart[startIndex+1:endIndex]
                    antimalwareconfig.append(str(rtid))
        
        mscan = describe.find('manualScanConfigurationID')
        if mscan != -1:
            mpart = describe[mscan+26:]
            startIndex = mpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = mpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    mid = mpart[startIndex+1:endIndex]
                    antimalwareconfig.append(str(mid))
        
        sscan = describe.find('scheduledScanConfigurationID')
        if sscan != -1:
            spart = describe[sscan+29:]
            startIndex = spart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = spart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    ssid = spart[startIndex+1:endIndex]
                    antimalwareconfig.append(str(ssid))
    antimalwareconfig = list(dict.fromkeys(antimalwareconfig))

def AMconfigtenant1():
#Describe each AM config from tenant1
    global directorylist
    global fileextentionlist
    global filelist
    global antimalwareconfig
    print ("Getting Anti-Malware configuration from Tenant 1")
    for amconfig in antimalwareconfig:
        if int(amconfig) != 0:
            payload  = {}
            url = url_link_final + 'api/antimalwareconfigurations/' + str(amconfig)
            headers = {
                "api-secret-key": tenant1key,
                "api-version": "v1",
                "Content-Type": "application/json",
            }
            response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
            
            describe = str(response.text)
            allamconfig.append(describe)
            print(str(amconfig))

            index = describe.find('directoryListID')
            if index != -1:
                indexpart = describe[index+16:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        directorylist.append(str(indexid))
            index = describe.find('excludedDirectoryListID')
            if index != -1:
                indexpart = describe[index+24:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        directorylist.append(str(indexid))
            index = describe.find('excludedFileExtensionListID')
            if index != -1:
                indexpart = describe[index+28:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        fileextentionlist.append(str(indexid))
            index = describe.find('fileExtensionListID')
            if index != -1:
                indexpart = describe[index+20:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        fileextentionlist.append(str(indexid))
            index = describe.find('excludedFileListID')
            if index != -1:
                indexpart = describe[index+19:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        filelist.append(str(indexid))            
            index = describe.find('excludedProcessImageFileListID')
            if index != -1:
                indexpart = describe[index+31:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        filelist.append(str(indexid)) 
    directorylist = list(dict.fromkeys(directorylist))
    fileextentionlist = list(dict.fromkeys(fileextentionlist))
    filelist = list(dict.fromkeys(filelist))

def DirListTenant1():
    global directorylist
    global alldirectory
    print ("Getting lists from Tenant 1, if any.")                
    for dirlist in directorylist:
        payload  = {}
        url = url_link_final + 'api/directorylists/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        #describe = describe[:-1]
        #describe = describe[2:]
        alldirectory.append(describe)
    print("Tenant1 directory list")
    print(directorylist)

def FileExtensionListTenant1():
    global fileextentionlist
    global allfileextention
    for dirlist in fileextentionlist:
        payload  = {}
        url = url_link_final + 'api/fileextensionlists/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        #describe = describe[:-1]
        #describe = describe[2:]
        allfileextention.append(describe)
    print("Tenant1 file extention list")
    print(fileextentionlist)
def FileListTenant1():
    global filelist
    global allfilelist
    for dirlist in filelist:
        payload  = {}
        url = url_link_final + 'api/filelists/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        #describe = describe[:-1]
        #describe = describe[2:]
        allfilelist.append(describe)
    print("Tenant1 file list")
    print(filelist)

def RenameLists():
#Rename each list
    global alldirectory
    global allfilelist
    global allfileextention
    count = 0
    for describe in alldirectory:
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    newname = indexid + " - Migrated"
                    alldirectory[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-1:]                  
        count = count + 1
    count = 0
    for describe in allfilelist:
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    newname = indexid + " - Migrated"
                    allfilelist[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-1:]
        count = count + 1
    count = 0
    for describe in allfileextention:
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    newname = indexid + " - Migrated"
                    allfileextention[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-1:]  
        count = count + 1

def DirListTenant2():
    global alldirectory
    global alldirectorynew
    print("Creating list to tenant 2, if any")
    for count, dirlist in enumerate(alldirectory):
        rename = 1
        namecheck = 1
        while namecheck != -1:
            payload = dirlist
            url = url_link_final_2 + 'api/directorylists'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('name already exists')
            if index != -1:
                describe1 = alldirectory[count]
                index = describe1.find('name')
                if index != -1:
                    indexpart = describe1[index+5:]
                    startIndex = indexpart.find('\"')
                    if startIndex != -1: #i.e. if the first quote was found
                        endIndex = indexpart.find('\"', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-1:]
                                    rename = rename + 1
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-1:]
                                rename = rename + 1
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        alldirectorynew.append(str(indexid))
                        namecheck = -1
            
    print("new directory list")
    print(alldirectorynew)
def FileExtensionListTenant2():
    global allfileextention
    global allfileextentionnew
    for count, dirlist in enumerate(allfileextention):
        rename = 1
        namecheck = 1
        while namecheck != -1:
            payload = dirlist
            url = url_link_final_2 + 'api/fileextensionlists'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('name already exists')
            if index != -1:
                describe1 = allfileextention[count]
                index = describe1.find('name')
                if index != -1:
                    indexpart = describe1[index+5:]
                    startIndex = indexpart.find('\"')
                    if startIndex != -1: #i.e. if the first quote was found
                        endIndex = indexpart.find('\"', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-1:]
                                    rename = rename + 1
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-1:]
                                rename = rename + 1
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allfileextentionnew.append(str(indexid))  
                        namecheck = -1
    print("new file extention")
    print(allfileextentionnew)

def FileListTenant2():
    global allfilelist
    global allfilelistnew
    for count, dirlist in enumerate(allfilelist):
        rename = 1
        namecheck = 1
        while namecheck != -1:
            payload = dirlist
            url = url_link_final_2 + 'api/filelists'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('name already exists')
            if index != -1:
                describe1 = allfilelist[count]
                index = describe1.find('name')
                if index != -1:
                    indexpart = describe1[index+5:]
                    startIndex = indexpart.find('\"')
                    if startIndex != -1: #i.e. if the first quote was found
                        endIndex = indexpart.find('\"', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-1:]
                                    rename = rename + 1
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-1:]
                                rename = rename + 1
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allfilelistnew.append(str(indexid))
                        namecheck = -1
    print("new file list")
    print(allfilelistnew)  
def AmConfigCheck():
    global allamconfig
    global directorylist
    global alldirectorynew
    global fileextentionlist
    global allfileextentionnew
    global filelist
    global allfilelistnew

    count = 0
    for describe in allamconfig:
        count1 = 0
        index = describe.find('\"directoryListID\"')
        if index != -1:
            indexpart = describe[index+17:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in directorylist:
                        if indexid == dirlist:
                            if alldirectorynew:
                                describe = describe[:index+17+startIndex+1] + alldirectorynew[count1] + describe[index+17+startIndex+endIndex:]
                        count1 = count1 + 1   
        count1 = 0
        index = describe.find('excludedDirectoryListID')
        if index != -1:
            indexpart = describe[index+24:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in directorylist:
                        if indexid == dirlist:
                            if alldirectorynew:
                                describe = describe[:index+24+startIndex+1] + alldirectorynew[count1] + describe[index+24+startIndex+endIndex:]
                        count1 = count1 + 1
        count1 = 0
        index = describe.find('excludedFileExtensionListID')
        if index != -1:
            indexpart = describe[index+28:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in fileextentionlist:
                        if indexid == dirlist:
                            if allfileextentionnew:
                                describe = describe[:index+28+startIndex+1] + allfileextentionnew[count1] + describe[index+28+startIndex+endIndex:]
                        count1 = count1 + 1
        count1 = 0
        index = describe.find('\"fileExtensionListID\"')
        if index != -1:
            indexpart = describe[index+21]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in fileextentionlist:
                        if indexid == dirlist:
                            if allfileextentionnew:
                                describe = describe[:index+21+startIndex+1] + allfileextentionnew[count1] + describe[index+21+startIndex+endIndex:]
                        count1 = count1 + 1
        count1 = 0
        index = describe.find('excludedFileListID')
        if index != -1:
            indexpart = describe[index+19:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in filelist:
                        if indexid == dirlist:
                            if allfilelistnew:
                                describe = describe[:index+19+startIndex+1] + allfilelistnew[count1] + describe[index+19+startIndex+endIndex:]
                        count1 = count1 + 1
        count1 = 0        
        index = describe.find('excludedProcessImageFileListID')
        if index != -1:
            indexpart = describe[index+31:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in filelist:
                        if indexid == dirlist:
                            if allfilelistnew:
                                describe = describe[:index+31+startIndex+1] + allfilelistnew[count1] + describe[index+31+startIndex+endIndex:]
                        count1 = count1 + 1
        allamconfig[count] = describe
        count = count + 1

def RenameAmConfig():
    global allamconfig
    count = 0
    for describe in allamconfig:         
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    newname = indexid + " - Migrated"
                    allamconfig[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-1:]
        count = count + 1

def AmconfigTenant2():
    global allamconfig
    global allamconfignew
    print("Creating Anti-Malware Configuration to Tenant2")
    for count, dirlist in enumerate(allamconfig):
        rename = 1
        namecheck = 1
        if dirlist != 0:
            while namecheck != -1:
                payload = dirlist
                url = url_link_final_2 + 'api/antimalwareconfigurations'
                headers = {
                "api-secret-key": tenant2key,
                "api-version": "v1",
                "Content-Type": "application/json",
                }
                response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                describe = str(response.text)
                index = describe.find('name already exists')
                if index != -1:
                    describe1 = allamconfig[count]
                    index = describe1.find('name')
                    if index != -1:
                        indexpart = describe1[index+5:]
                        startIndex = indexpart.find('\"')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find('\"', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid = indexpart[startIndex+1:endIndex]
                                startIndex2 = indexid.find('(')
                                if startIndex2 != -1:
                                    endIndex2 = indexid.find(')', startIndex2 + 1)
                                    if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                        indexid = indexid[startIndex2+1:endIndex2]
                                        dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-1:]
                                        rename = rename + 1
                                else:
                                    newname = indexid + " (" + str(rename) + ")"
                                    dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-1:]
                                    rename = rename + 1
                index = describe.find('\"ID\"')
                if index != -1:
                    indexpart = describe[index+4:]
                    startIndex = indexpart.find(':')
                    if startIndex != -1: #i.e. if the first quote was found
                        endIndex = indexpart.find(',', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allamconfignew.append(str(indexid))
                            namecheck = -1
                        else:   
                            endIndex = indexpart.find('}', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid = indexpart[startIndex+1:endIndex]
                                allamconfignew.append(str(indexid))   
                                namecheck = -1
                
    print("New AM Config ID")
    print(allamconfignew)

def AmReplaceConfig():
    global allofpolicy
    global antimalwareconfig
    global allamconfignew
    count = 0
    for describe in allofpolicy:
        count1 = 0
        index = describe.find('realTimeScanConfigurationID')
        if index != -1:
            indexpart = describe[index+28:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in antimalwareconfig:
                        if int(dirlist) != 0:
                            if indexid == dirlist:
                                describe = describe[:index+28+startIndex+1] + allamconfignew[count1] + describe[index+28+startIndex+endIndex:]
                            count1 = count1 + 1    
        count1 = 0
        index = describe.find('manualScanConfigurationID')
        if index != -1:
            indexpart = describe[index+26:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in antimalwareconfig:
                        if int(dirlist) != 0:
                            if indexid == dirlist:
                                describe = describe[:index+26+startIndex+1] + allamconfignew[count1] + describe[index+26+startIndex+endIndex:]
                            count1 = count1 + 1          
        count1 = 0
        index = describe.find('scheduledScanConfigurationID')
        if index != -1:
            indexpart = describe[index+29:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    for dirlist in antimalwareconfig:
                        if int(dirlist) != 0:
                            if indexid == dirlist:
                                describe = describe[:index+29+startIndex+1] + allamconfignew[count1] + describe[index+29+startIndex+endIndex:]
                            count1 = count1 + 1

        allofpolicy[count] = describe
        count = count + 1

def RenamePolicy():
    global allofpolicy
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    newname = indexid + " - Migrated"
                    change1 = describe[:index+6+startIndex+1] + newname + describe[index+6+startIndex+endIndex-1:]
        index = change1.find('parentID')
        if index != -1:
            indexpart = change1[index+8:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    newname = "1"
                    allofpolicy[count] = change1[:index+8+startIndex+1] + newname + change1[index+8+startIndex+endIndex-1:]
def FirewallGet():
    global allofpolicy
    global firewallruleid
#find all Firewall rules
    print ("Firewall rules in Tenant 1")
    for describe in allofpolicy:
        index = describe.find('\"firewall\"')
        if index != -1:
            indexpart = describe[index+9:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index = indexid.find('ruleIDs')
                    if index != -1:
                        indexpart = describe[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                firewallruleid.extend(indexid2)
    firewallruleid = list(dict.fromkeys(firewallruleid))
    print(firewallruleid)

def FirewallDescribe():
    global allfirewallrule
    global allfirewallrulename
    global allfirewallruleidnew1
    global allfirewallruleidold
    global allfirewallcustomrule
#describe Firewall rules
    print("Searching Firewall rules in Tenant 2...")      
    for dirlist in firewallruleid:
        payload  = {}
        url = url_link_final + 'api/firewallrules/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        allfirewallrule.append(describe)
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    allfirewallrulename.append(str(indexid))
    for count, dirlist in enumerate(allfirewallrulename):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/firewallrules/search'
        headers = {
        "api-secret-key": tenant2key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        index = describe.find(dirlist)
        if index != -1:
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allfirewallruleidnew1.append(str(indexid))
                        allfirewallruleidold.append(count)
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allfirewallruleidnew1.append(str(indexid))
                            allfirewallruleidold.append(count) 
        else:
            allfirewallcustomrule.append(count)
    print("Tenant 2 default firewall rules")
    print(allfirewallruleidnew1)
def FirewallCustom():
    global allfirewallcustomrule
    global allfirewallrule
    global allfirewallruleidnew2
    if allfirewallcustomrule:
        for indexnum in allfirewallcustomrule:
            payload = allfirewallrule[indexnum]
            url = url_link_final_2 + 'api/firewallrules'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allfirewallruleidnew2.append(str(indexid))
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allfirewallruleidnew2.append(str(indexid))
    print("all new firewall rule custom rule")
    print(allfirewallruleidnew2)

def FirewallReplace():
    global allofpolicy
    global allfirewallruleidnew1
    global allfirewallruleidnew2
    global firewallruleid
    global allfirewallruleidold
    global allfirewallcustomrule
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"firewall\"')
        if index != -1:
            indexpart = describe[index+9:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index2 = indexid.find('ruleIDs')
                    if index2 != -1:
                        indexpart2 = describe[index2+9:]
                        startIndex2 = indexpart2.find('[')
                        if startIndex2 != -1: #i.e. if the first quote was found
                            endIndex2 = indexpart2.find(']', startIndex2 + 1)
                            if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                indexid2 = indexpart2[startIndex2+1:endIndex2]
                                indexid3 = indexpart2[startIndex2+1:endIndex2]
                                indexid4 = indexid2.split(",")
                                if allfirewallruleidnew1 or allfirewallruleidnew2:
                                    for count1, this in enumerate(indexid4):
                                        checkindex = firewallruleid.index(this)
                                        if checkindex in allfirewallruleidold:
                                            checkindex1 = allfirewallruleidold.index(checkindex)
                                            indexid4[count1] = allfirewallruleidnew1[checkindex1]
                                        elif checkindex in allfirewallcustomrule:
                                            checkindex1 = allfirewallcustomrule.index(checkindex)
                                            indexid4[count1] = allfirewallruleidnew2[checkindex1]
                                    indexid2 = ",".join(indexid4)
                                modulepart = describe[index:index+9+endIndex]
                                modulepart2 = modulepart.replace(indexid3, indexid2)
                                allofpolicy[count] = describe.replace(modulepart, modulepart2)

def IPSappGet():
    global allofpolicy
    global ipsappid
    print ("IPS application types in Tenant 1")
    for describe in allofpolicy:
        index = describe.find('\"intrusionPrevention\"')
        if index != -1:
            indexpart = describe[index+20:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index = indexid.find('applicationTypeIDs')
                    if index != -1:
                        indexpart = describe[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                ipsappid.extend(indexid2)
    ipsappid = list(dict.fromkeys(ipsappid))
    print(ipsappid)

def IPSappDescribe():
    global ipsappid
    global allipsapp
    global allipsappname
    global allipsappidnew1
    global allipsappidold
    global allipscustomapp

    print("Searching IPS application types in Tenant 2...")  
    for dirlist in ipsappid:
        payload  = {}
        url = url_link_final + 'api/applicationtypes/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        allipsapp.append(describe)
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    allipsappname.append(str(indexid))
    for count, dirlist in enumerate(allipsappname):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/applicationtypes/search'
        headers = {
        "api-secret-key": tenant2key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        index = describe.find(dirlist)
        if index != -1:
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allipsappidnew1.append(str(indexid))
                        allipsappidold.append(count)
        else:
            allipscustomapp.append(count)
    print("Tenant 2 default IPS application type")
    print(allipsappidnew1)

def IPSappCustom():
    global allipscustomapp
    global allipsapp
    global allipsappidnew2
    if allipscustomapp:
        for indexnum in allipscustomapp:
            payload = allipsapp[indexnum]
            url = url_link_final_2 + 'api/applicationtypes'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allipsappidnew2.append(str(indexid))
    print("all new IPS custom application")
    print(allipsappidnew2)

def IPSappReplace():
    global allofpolicy
    global allipsappidnew1
    global allipsappidnew2
    global ipsappid
    global allipsappidold
    global allipscustomapp
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"intrusionPrevention\"')
        if index != -1:
            indexpart = describe[index+20:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index2 = indexid.find('applicationTypeIDs')
                    if index2 != -1:
                        indexpart2 = describe[index2+9:]
                        startIndex2 = indexpart2.find('[')
                        if startIndex2 != -1: #i.e. if the first quote was found
                            endIndex2 = indexpart2.find(']', startIndex2 + 1)
                            if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                indexid2 = indexpart2[startIndex2+1:endIndex2]
                                indexid3 = indexpart2[startIndex2+1:endIndex2]
                                indexid4 = indexid2.split(",")
                                if allipsappidnew1 or allipsappidnew2:
                                    for count1, this in enumerate(indexid4):
                                        checkindex = ipsappid.index(this)
                                        if checkindex in allipsappidold:
                                            checkindex1 = allipsappidold.index(checkindex)
                                            indexid4[count1] = allipsappidnew1[checkindex1]
                                        elif checkindex in allipscustomapp:
                                            checkindex1 = allipscustomapp.index(checkindex)
                                            indexid4[count1] = allipsappidnew2[checkindex1]
                                    indexid2 = ",".join(indexid4)
                                modulepart = describe[index:index+20+endIndex]
                                modulepart2 = modulepart.replace(indexid3, indexid2)
                                allofpolicy[count] = describe.replace(modulepart, modulepart2)

def IPSGet():
    global allofpolicy
    global ipsruleid
    print ("IPS rules in Tenant 1")
    for describe in allofpolicy:
        index = describe.find('\"intrusionPrevention\"')
        if index != -1:
            indexpart = describe[index+20:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index = indexid.find('ruleIDs')
                    if index != -1:
                        indexpart = describe[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                ipsruleid.extend(indexid2)
    ipsruleid = list(dict.fromkeys(ipsruleid))
    print(ipsruleid)

def IPSDescribe():
    global allipsrule
    global allipsrulename
    global allipsruleidnew1
    global allipsruleidold
    global allipscustomrule
    print("Searching IPS rules in Tenant 2...")
    for dirlist in ipsruleid:
        payload  = {}
        url = url_link_final + 'api/intrusionpreventionrules/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        allipsrule.append(describe)
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    allipsrulename.append(str(indexid))
    
    for count, dirlist in enumerate(allipsrulename):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/intrusionpreventionrules/search'
        headers = {
        "api-secret-key": tenant2key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        index = describe.find(dirlist)
        if index != -1:
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allipsruleidnew1.append(str(indexid))
                        allipsruleidold.append(count)
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allipsruleidnew1.append(str(indexid))
                            allipsruleidold.append(count)
        else:
            allipscustomrule.append(count)
    print("Tenant 2 default IPS rules")
    print(allipsruleidnew1)

def IPSCustom():
    global allipscustomrule
    global allipsrule
    global allipsruleidnew2
    if allipscustomrule:
        for indexnum in allipscustomrule:
            payload = allipsrule[indexnum]
            url = url_link_final_2 + 'api/intrusionpreventionrules'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allipsruleidnew2.append(str(indexid))
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allipsruleidnew2.append(str(indexid))
    print("all new IPS rule custom rule")
    print(allipsruleidnew2)

def IPSReplace():
    global allofpolicy
    global allipsruleidnew1
    global allipsruleidnew2
    global ipsruleid
    global allipsruleidold
    global allipscustomrule
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"intrusionPrevention\"')
        if index != -1:
            indexpart = describe[index+20:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index2 = indexid.find('ruleIDs')
                    if index2 != -1:
                        indexpart2 = describe[index2+9:]
                        startIndex2 = indexpart2.find('[')
                        if startIndex2 != -1: #i.e. if the first quote was found
                            endIndex2 = indexpart2.find(']', startIndex2 + 1)
                            if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                indexid2 = indexpart2[startIndex2+1:endIndex2]
                                indexid3 = indexpart2[startIndex2+1:endIndex2]
                                indexid4 = indexid2.split(",")
                                if allipsruleidnew1 or allipsruleidnew2:
                                    for count1, this in enumerate(indexid4):
                                        checkindex = ipsruleid.index(this)
                                        if checkindex in allipsruleidold:
                                            checkindex1 = allipsruleidold.index(checkindex)
                                            indexid4[count1] = allipsruleidnew1[checkindex1]
                                        elif checkindex in allipscustomrule:
                                            checkindex1 = allipscustomrule.index(checkindex)
                                            indexid4[count1] = allipsruleidnew2[checkindex1]
                                    indexid2 = ",".join(indexid4)
                                modulepart = describe[index:index+20+endIndex]
                                modulepart2 = modulepart.replace(indexid3, indexid2)
                                allofpolicy[count] = describe.replace(modulepart, modulepart2)


def LIGet():
    global allofpolicy
    global liruleid
    print ("Log Inspection rules in Tenant 1")
    for describe in allofpolicy:
        index = describe.find('\"logInspection\"')
        if index != -1:
            indexpart = describe[index+14:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index = indexid.find('ruleIDs')
                    if index != -1:
                        indexpart = describe[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                liruleid.extend(indexid2)
    liruleid = list(dict.fromkeys(liruleid))
    print(liruleid) 

def LIDescribe():
    global alllirule
    global alllirulename
    global allliruleidnew1
    global allliruleidold
    global alllicustomrule
    print("Searching LI rules in Tenant 2...")                  
    for dirlist in liruleid:
        payload  = {}
        url = url_link_final + 'api/loginspectionrules/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        alllirule.append(describe)
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    alllirulename.append(str(indexid))

    for count, dirlist in enumerate(alllirulename):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/loginspectionrules/search'
        headers = {
        "api-secret-key": tenant2key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        index = describe.find(dirlist)
        if index != -1:
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allliruleidnew1.append(str(indexid))
                        allliruleidold.append(count)
        else:
            alllicustomrule.append(count)
    print("Tenant 2 default LI rules")
    print(allliruleidnew1)

def LICustom():
    global alllicustomrule
    global alllirule
    global allliruleidnew2
    if alllicustomrule:
        for indexnum in alllicustomrule:
            payload = alllirule[indexnum]
            url = url_link_final_2 + 'api/loginspectionrules'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allliruleidnew2.append(str(indexid))
    print("all new LI rule custom rule")
    print(allliruleidnew2)

def LIReplace():
    global allofpolicy
    global allliruleidnew1
    global allliruleidnew2
    global liruleid
    global allliruleidold
    global alllicustomrule
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"logInspection\"')
        if index != -1:
            indexpart = describe[index+14:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index2 = indexid.find('ruleIDs')
                    if index2 != -1:
                        indexpart2 = describe[index2+9:]
                        startIndex2 = indexpart2.find('[')
                        if startIndex2 != -1: #i.e. if the first quote was found
                            endIndex2 = indexpart2.find(']', startIndex2 + 1)
                            if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                indexid2 = indexpart2[startIndex2+1:endIndex2]
                                indexid3 = indexpart2[startIndex2+1:endIndex2]
                                indexid4 = indexid2.split(",")
                                if allliruleidnew1 or allliruleidnew2:
                                    for count1, this in enumerate(indexid4):
                                        checkindex = liruleid.index(this)
                                        if checkindex in allliruleidold:
                                            checkindex1 = allliruleidold.index(checkindex)
                                            indexid4[count1] = allliruleidnew1[checkindex1]
                                        elif checkindex in alllicustomrule:
                                            checkindex1 = alllicustomrule.index(checkindex)
                                            indexid4[count1] = allliruleidnew2[checkindex1]
                                    indexid2 = ",".join(indexid4)
                                modulepart = describe[index:index+14+endIndex]
                                modulepart2 = modulepart.replace(indexid3, indexid2)
                                allofpolicy[count] = describe.replace(modulepart, modulepart2)

def IMGet():
    global allofpolicy
    global imruleid
    print ("IM rules in Tenant 1")
    for describe in allofpolicy:
        index = describe.find('\"integrityMonitoring\"')
        if index != -1:
            indexpart = describe[index+20:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index = indexid.find('ruleIDs')
                    if index != -1:
                        indexpart = describe[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                imruleid.extend(indexid2)
    imruleid = list(dict.fromkeys(imruleid))
    print(imruleid)

def IMDescribe():
    global allimrule
    global allimrulename
    global allimruleidnew1
    global allimruleidold
    global allimcustomrule
    print("Searching IM rules in Tenant 2...")                    
    for dirlist in imruleid:
        payload  = {}
        url = url_link_final + 'api/integritymonitoringrules/' + str(dirlist)
        headers = {
            "api-secret-key": tenant1key,
            "api-version": "v1",
            "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        allimrule.append(describe)
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    allimrulename.append(str(indexid))
    
    for count, dirlist in enumerate(allimrulename):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/integritymonitoringrules/search'
        headers = {
        "api-secret-key": tenant2key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text.encode('utf8'))
        describe = describe[:-1]
        describe = describe[2:]
        index = describe.find(dirlist)
        if index != -1:
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allimruleidnew1.append(str(indexid))
                        allimruleidold.append(count)
        else:
            allimcustomrule.append(count)
    print("Tenant 2 default IM rules")
    print(allimruleidnew1)

def IMCustom():
    global allimcustomrule
    global allimrule
    global allimruleidnew2
    if allimcustomrule:
        for indexnum in allimcustomrule:
            payload = allimrule[indexnum]
            url = url_link_final_2 + 'api/integritymonitoringrules'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        allimruleidnew2.append(str(indexid))
    print("all new im rule custom rule")
    print(allimruleidnew2)

def IMReplace():
    global allofpolicy
    global allimruleidnew1
    global allimruleidnew2
    global imruleid
    global allimruleidold
    global allimcustomrule
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"integrityMonitoring\"')
        if index != -1:
            indexpart = describe[index+20:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index2 = indexid.find('ruleIDs')
                    if index2 != -1:
                        indexpart2 = describe[index2+9:]
                        startIndex2 = indexpart2.find('[')
                        if startIndex2 != -1: #i.e. if the first quote was found
                            endIndex2 = indexpart2.find(']', startIndex2 + 1)
                            if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                indexid2 = indexpart2[startIndex2+1:endIndex2]
                                indexid3 = indexpart2[startIndex2+1:endIndex2]
                                indexid4 = indexid2.split(",")
                                if allimruleidnew1 or allimruleidnew2:
                                    for count1, this in enumerate(indexid4):
                                        checkindex = imruleid.index(this)
                                        if checkindex in allimruleidold:
                                            checkindex1 = allimruleidold.index(checkindex)
                                            indexid4[count1] = allimruleidnew1[checkindex1]
                                        elif checkindex in allimcustomrule:
                                            checkindex1 = allimcustomrule.index(checkindex)
                                            indexid4[count1] = allimruleidnew2[checkindex1]
                                    indexid2 = ",".join(indexid4)
                                modulepart = describe[index:index+20+endIndex]
                                modulepart2 = modulepart.replace(indexid3, indexid2)
                                allofpolicy[count] = describe.replace(modulepart, modulepart2)

def AddPolicy():
    global allofpolicy
    print ("Creating Policy to Tenant 2 with new ID")  
    for count, dirlist in enumerate(allofpolicy):
        rename = 1
        namecheck = 1
        while namecheck != -1:
            payload = dirlist
            url = url_link_final_2 + 'api/policies'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find('name already exists')
            if index != -1:
                describe1 = allofpolicy[count]
                index = describe1.find('\"name\"')
                if index != -1:
                    indexpart = describe1[index+6:]
                    startIndex = indexpart.find('\"')
                    if startIndex != -1: #i.e. if the first quote was found
                        endIndex = indexpart.find('\"', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+6+startIndex+startIndex2+1] + str(rename) + describe1[index+6+startIndex+startIndex2+endIndex2-1:]
                                    rename = rename + 1
                                    
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+6+startIndex+1] + newname + describe1[index+6+startIndex+endIndex-1:]
                                rename = rename + 1
                                
            
            index = describe.find('\"ID\"')
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        print(indexid)
                        namecheck = -1
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            print(indexid)
                            namecheck = -1

def Migrate():
    print ("-==Migration Options==-")
    print ("1. Policies")
    print ("2. Event-Based Task")
    print ("3. Schedued-Based Task")
    Input1 = input("Please enter the number you want to migrate: ")
    #Input1 = input()
    if Input1 == "1":
    #save all policy to a text file then find each ID and name
        ListAllPolicyAPI()
        policyIDs = input("Input policy ID/s (if more than one, put space in between each ID): ")
        GetPolicy(policyIDs)
        AMconfigtenant1()
        DirListTenant1()
        FileExtensionListTenant1()               
        FileListTenant1()
        RenameLists()     
        #create each list to tenant 2                  
        DirListTenant2()
        FileExtensionListTenant2()
        FileListTenant2()
    #Check AM Config lists and replace the old one
        AmConfigCheck()
    #Rename AM Configs
        RenameAmConfig()
    #create AM Configs to tenant 2
        AmconfigTenant2()
    #Replace old AM config with new AM config
        AmReplaceConfig()
    #Rename Policy
        RenamePolicy()
#all about Firewall rules
        FirewallGet()
        FirewallDescribe()
    #Create custom Firewall rules
        FirewallCustom()
    #replace old firewall rule with tenant 2
        FirewallReplace()
#all about IPS rules
    #find all IPS application ID
        IPSappGet()
    #describe IPS app ID
        IPSappDescribe()
    #Create custom IPS app
        IPSappCustom()
    #replace old ips app with tenant 2
        IPSappReplace()
    #find all ips rules
        IPSGet()
    #describe IPS rule
        IPSDescribe()
    #Create custom IPS rules
        IPSCustom()
    #replace old IPS rule with tenant 2
        IPSReplace()
#all about log rules
    #find all log rules
        LIGet()
    #describe log rule
        LIDescribe()
    #Create custom LI rules
        LICustom()
    #replace old LI rule with tenant 2
        LIReplace()
#all about IM rules
    #find all IM rules
        IMGet()
    #describe IM rule
        IMDescribe()
    #Create custom IM rules
        IMCustom()
    #replace old IM rule with tenant 2
        IMReplace()
    #create Policy to tenant 2    
        AddPolicy()
        sys.exit()
    elif Input1 == "2":
        print("Not yet available")
        Migrate()
    elif Input1 == "3":
        print("Not yet available")
        Migrate()
    else:
        print("Please choose a number")
        Migrate()


#print("Input First Tenant API Key (Not yet working)")
Migrate()
sys.exit()
