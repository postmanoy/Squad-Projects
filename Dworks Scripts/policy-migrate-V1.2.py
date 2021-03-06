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
    index = 0
    oldpolicyname = []
    oldpolicyid = []
    while index != -1:
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
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
    antimalwareconfig = []
    allofpolicy = []
    i = 0
    print ("Getting Policy ID from Tenant 1...")
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
    print ('Done!')
    return antimalwareconfig, allofpolicy

def AMconfigtenant1(antimalwareconfig):
#Describe each AM config from tenant1
    allamconfig = []
    directorylist = []
    fileextentionlist = []
    filelist = []
    print ("Getting each Anti-Malware configuration ID from Tenant 1...")
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
    print("Done!")
    return directorylist, fileextentionlist, filelist, allamconfig

def DirListTenant1(directorylist):
    alldirectory = []
    print ("Getting Exclusion lists from Tenant 1, if any...")                
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
    print("All Tenant 1 directory list")
    print(directorylist)
    return alldirectory

def FileExtensionListTenant1(fileextentionlist):
    allfileextention = []
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
    print("All Tenant 1 file extention list")
    print(fileextentionlist)
    return allfileextention
    
def FileListTenant1(filelist):
    allfilelist = []
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
    print("All Tenant 1 file list")
    print(filelist)
    return allfilelist

def RenameLists(alldirectory, allfilelist, allfileextention):
    count = 0
    for describe in alldirectory:
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    newname = indexid + " - Migrated"
                    alldirectory[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-2:]                  
        count = count + 1
    count = 0
    for describe in allfilelist:
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    newname = indexid + " - Migrated"
                    allfilelist[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-2:]
        count = count + 1
    count = 0
    for describe in allfileextention:
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    newname = indexid + " - Migrated"
                    allfileextention[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-2:]  
        count = count + 1
    return alldirectory, allfilelist, allfileextention

def DirListTenant2(alldirectory):
    alldirectorynew = []
    print("Transfering Exclusion list to tenant 2, if any")
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
                        endIndex = indexpart.find(',', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex-1]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-2:]
                                    rename = rename + 1
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-2:]
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
    print("Finished Transfering Directory List")
    print("New directory list ID")
    print(alldirectorynew)
    return alldirectorynew

def FileExtensionListTenant2(allfileextention):
    allfileextentionnew = []
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
                        endIndex = indexpart.find(',', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex-1]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-2:]
                                    rename = rename + 1
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-2:]
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
    print("Finished Transfering File Extention List")
    print("New file extention ID")
    print(allfileextentionnew)
    return allfileextentionnew

def FileListTenant2(allfilelist):
    allfilelistnew = []
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
                        endIndex = indexpart.find(',', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex-1]
                            startIndex2 = indexid.find('{')
                            if startIndex2 != -1:
                                endIndex2 = indexid.find('}', startIndex2 + 1)
                                if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                    indexid = indexid[startIndex2+1:endIndex2]
                                    dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-2:]
                                    rename = rename + 1
                            else:
                                newname = indexid + " {" + str(rename) + "}"
                                dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-2:]
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
    print("Finished Transfering File List")
    print("New file list ID")
    print(allfilelistnew)
    return allfilelistnew

def AmConfigCheck(allamconfig, directorylist, alldirectorynew, fileextentionlist, allfileextentionnew, filelist, allfilelistnew):
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
    return allamconfig

def RenameAmConfig(allamconfig):
    count = 0
    for describe in allamconfig:         
        index = describe.find('name')
        if index != -1:
            indexpart = describe[index+5:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    newname = indexid + " - Migrated"
                    allamconfig[count] = describe[:index+5+startIndex+1] + newname + describe[index+5+startIndex+endIndex-2:]
        count = count + 1
    return allamconfig

def AmconfigTenant2(allamconfig):
    allamconfignew = []
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
                            endIndex = indexpart.find(',', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid = indexpart[startIndex+1:endIndex-1]
                                startIndex2 = indexid.find('(')
                                if startIndex2 != -1:
                                    endIndex2 = indexid.find(')', startIndex2 + 1)
                                    if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                        indexid = indexid[startIndex2+1:endIndex2]
                                        dirlist = describe1[:index+5+startIndex+startIndex2+1] + str(rename) + describe1[index+5+startIndex+startIndex2+endIndex2-2:]
                                        rename = rename + 1
                                else:
                                    newname = indexid + " (" + str(rename) + ")"
                                    dirlist = describe1[:index+5+startIndex+1] + newname + describe1[index+5+startIndex+endIndex-2:]
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
    print("Finished Transfering Anti-Malware Configuration.")
    print("New AM Config ID")
    print(allamconfignew)
    return allamconfignew

def AmReplaceConfig(allofpolicy, antimalwareconfig, allamconfignew):
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
    return allofpolicy

def RenamePolicy(allofpolicy):
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    newname = indexid + " - Migrated"
                    change1 = describe[:index+6+startIndex+1] + newname + describe[index+6+startIndex+endIndex-2:]
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
    return allofpolicy

def IpListGet():
    t1iplistall = []
    t1iplistname = []
    t1iplistid = []
    print("Getting All IP List ID...")
    payload  = {}
    url = url_link_final + 'api/iplists'
    headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
    }
    response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
    describe = str(response.text)
    describe2 = str(response.text)
    index = describe.find('\"ipLists\"')
    if index != -1:
        indexpart = describe[index+11:]
        startIndex = 0
        while startIndex != -1: 
            startIndex = indexpart.find('{')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex:endIndex+1]
                    t1iplistall.append(str(indexid))
                    indexpart = indexpart[endIndex:]
    index = describe.find('\"ipLists\"')
    while index != -1:
            index = describe2.find('\"name\"')
            if index != -1:
                indexpart = describe2[index+6:]
                startIndex = indexpart.find('\"')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex-1]
                        t1iplistname.append(str(indexid))
                        describe2 = indexpart[endIndex:]
                        index = describe2.find('\"ID\"')
                        if index != -1:
                            indexpart = describe2[index+3:]
                            startIndex = indexpart.find(':')
                            if startIndex != -1: #i.e. if the first quote was found
                                endIndex = indexpart.find('}', startIndex + 1)
                                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                    indexid = indexpart[startIndex+1:endIndex]
                                    t1iplistid.append(str(indexid))
                                    print(indexid)
                                    describe2 = indexpart[endIndex:]
    #print("All IP List ID...")
    #print(t1iplistid)
    print("Done!")
    return t1iplistall, t1iplistname, t1iplistid

def IpListCreate(t1iplistall, t1iplistname):
    t2iplistid = []
    print("Transfering All IP List...")
    for count, dirlist in enumerate(t1iplistname):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/iplists/search'
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
                        payload = t1iplistall[count]
                        url = url_link_final_2 + 'api/iplists/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                        t2iplistid.append(str(indexid))
                        print(indexid)
        else:
            payload = t1iplistall[count]
            url = url_link_final_2 + 'api/iplists'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        t2iplistid.append(str(indexid))
                        print(indexid)
    #print("Finished Transfering All IP List.")
    #print(t2iplistid)
    print("Done!")
    return t2iplistid

def MacListGet():
    t1maclistall = []
    t1maclistname = []
    t1maclistid = []
    print("Getting All Mac List ID...")
    payload  = {}
    url = url_link_final + 'api/maclists'
    headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
    }
    response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
    describe = str(response.text)
    describe2 = str(response.text)
    index = describe.find('\"macLists\"')
    if index != -1:
        indexpart = describe[index+10:]
        startIndex = 0
        while startIndex != -1: 
            startIndex = indexpart.find('{')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex:endIndex+1]
                    t1maclistall.append(str(indexid))
                    indexpart = indexpart[endIndex:]
    while index != -1:
            index = describe2.find('\"name\"')
            if index != -1:
                indexpart = describe2[index+6:]
                startIndex = indexpart.find('\"')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex-1]
                        t1maclistname.append(str(indexid))
                        describe2 = indexpart[endIndex:]
                        index = describe2.find('\"ID\"')
                        if index != -1:
                            indexpart = describe2[index+3:]
                            startIndex = indexpart.find(':')
                            if startIndex != -1: #i.e. if the first quote was found
                                endIndex = indexpart.find('}', startIndex + 1)
                                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                    indexid = indexpart[startIndex+1:endIndex]
                                    t1maclistid.append(str(indexid))
                                    print(indexid)
                                    describe2 = indexpart[endIndex:]
    #print(t1maclistid)
    print("Done!")
    return t1maclistall, t1maclistname, t1maclistid

def MacListCreate(t1maclistall, t1maclistname):
    t2maclistid = []
    print("Transfering All Mac List...")
    for count, dirlist in enumerate(t1maclistname):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/maclists/search'
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
                        payload = t1maclistall[count]
                        url = url_link_final_2 + 'api/maclists/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                        t2maclistid.append(str(indexid))
                        print(indexid)
        else:
            payload = t1maclistall[count]
            url = url_link_final_2 + 'api/maclists'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        t2maclistid.append(str(indexid))
                        print(indexid)
    #print("Finished Transfering All Mac List.")
    #print(t2maclistid)
    print("Done!")
    return t2maclistid

def PortListGet():
    t1portlistall = []
    t1portlistname = []
    t1portlistid = []
    print("Getting All Port List ID...")
    payload  = {}
    url = url_link_final + 'api/portlists'
    headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
    }
    response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
    describe = str(response.text)
    describe2 = str(response.text)
    index = describe.find('\"portLists\"')
    if index != -1:
        indexpart = describe[index+10:]
        startIndex = 0
        while startIndex != -1: 
            startIndex = indexpart.find('{')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex:endIndex+1]
                    t1portlistall.append(str(indexid))
                    indexpart = indexpart[endIndex:]
    while index != -1:
            index = describe2.find('\"name\"')
            if index != -1:
                indexpart = describe2[index+6:]
                startIndex = indexpart.find('\"')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex-1]
                        t1portlistname.append(str(indexid))
                        describe2 = indexpart[endIndex:]
                        index = describe2.find('\"ID\"')
                        if index != -1:
                            indexpart = describe2[index+3:]
                            startIndex = indexpart.find(':')
                            if startIndex != -1: #i.e. if the first quote was found
                                endIndex = indexpart.find('}', startIndex + 1)
                                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                    indexid = indexpart[startIndex+1:endIndex]
                                    t1portlistid.append(str(indexid))
                                    print(indexid)
                                    describe2 = indexpart[endIndex:]
    #print(t1portlistid)
    print("Done!")
    return t1portlistall, t1portlistname, t1portlistid

def PortListCreate(t1portlistall, t1portlistname):
    t2portlistid = []
    print("Transfering All Port List...")
    for count, dirlist in enumerate(t1portlistname):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/portlists/search'
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
                        payload = t1portlistall[count]
                        url = url_link_final_2 + 'api/portlists/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                        t2portlistid.append(str(indexid))
                        print(indexid)
        else:
            payload = t1portlistall[count]
            url = url_link_final_2 + 'api/portlists'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        t2portlistid.append(str(indexid))
                        print(indexid)
    #print("Finished Transfering All Port List.")
    #print(t2portlistid)
    print("Done!")
    return t2portlistid

def StatefulGet():
    t1statefulall = []
    t1statefulname = []
    t1statefulid = []
    print("Getting All Stateful Configuration ID...")
    payload  = {}
    url = url_link_final + 'api/statefulconfigurations'
    headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
    }
    response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
    describe = str(response.text)
    describe2 = str(response.text)
    index = describe.find('\"statefulConfigurations\"')
    if index != -1:
        indexpart = describe[index+24:]
        startIndex = 0
        while startIndex != -1: 
            startIndex = indexpart.find('{')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex:endIndex+1]
                    t1statefulall.append(str(indexid))
                    indexpart = indexpart[endIndex:]
    while index != -1:
            index = describe2.find('\"name\"')
            if index != -1:
                indexpart = describe2[index+6:]
                startIndex = indexpart.find('\"')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex-1]
                        t1statefulname.append(str(indexid))
                        describe2 = indexpart[endIndex:]
                        index = describe2.find('\"ID\"')
                        if index != -1:
                            indexpart = describe2[index+3:]
                            startIndex = indexpart.find(':')
                            if startIndex != -1: #i.e. if the first quote was found
                                endIndex = indexpart.find('}', startIndex + 1)
                                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                    indexid = indexpart[startIndex+1:endIndex]
                                    t1statefulid.append(str(indexid))
                                    describe2 = indexpart[endIndex:]
                                    print(indexid)

    #print(t1statefulid)
    print("Done")
    return t1statefulall, t1statefulname, t1statefulid
def StatefulCreate(t1statefulall, t1statefulname):
    t2statefulid = []
    print("Transfering All Stateful Configuration...")
    for count, dirlist in enumerate(t1statefulname):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/statefulconfigurations/search'
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
                        payload = t1statefulall[count]
                        url = url_link_final_2 + 'api/statefulconfigurations/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                        t2statefulid.append(str(indexid))
                        print(indexid)
        else:
            payload = t1statefulall[count]
            url = url_link_final_2 + 'api/statefulconfigurations'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            describe = str(response.text)
            index = describe.find("\"ID\"")
            if index != -1:
                indexpart = describe[index+4:]
                startIndex = indexpart.find(':')
                if startIndex != -1: #i.e. if the first quote was found
                    endIndex = indexpart.find(',', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                        indexid = indexpart[startIndex+1:endIndex]
                        t2statefulid.append(str(indexid))
                        print(indexid)
    print(t2statefulid)
    return t2statefulid

def FirewallGet(allofpolicy):
    firewallruleid = []
    policystateful = []
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
                    index = indexid.find('globalStatefulConfigurationID')
                    if index != -1:
                        indexpart = indexid[index+29:]
                        startIndex = indexpart.find(':')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(',', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                policystateful.append(str(indexid1))
                    index = indexid.find('ruleIDs')
                    if index != -1:
                        indexpart = indexid[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                firewallruleid.extend(indexid2)
    firewallruleid = list(dict.fromkeys(firewallruleid))
    print(firewallruleid)
    return firewallruleid, policystateful

def FirewallDescribe(firewallruleid, t1iplistid, t2iplistid, t1maclistid, t2maclistid, t1portlistid, t2portlistid):
    allfirewallrule = []
    allfirewallrulename = []
    allfirewallruleidnew1 = []
    allfirewallruleidold = []
    allfirewallcustomrule = []
#describe Firewall rules
    print("Gathering Firewall rules in Tenant 1...")      
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
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    allfirewallrulename.append(str(indexid))
        print(dirlist)
    print("Done!")

    for count, describe in enumerate(allfirewallrule):
        index3 = describe.find('sourceIPListID')
        if index3 != -1:
            indexpart = describe[index3+14:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+14+endIndex3]
                    indexnum = t1iplistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2iplistid[indexnum])
                    describe = describe.replace(indexid5, listpart)
        index3 = describe.find('sourceMACListID')
        if index3 != -1:
            indexpart = describe[index3+15:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+15+endIndex3]
                    indexnum = t1maclistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2maclistid[indexnum])
                    describe = describe.replace(indexid5, listpart)
        index3 = describe.find('sourcePortListID')
        if index3 != -1:
            indexpart = describe[index3+16:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+16+endIndex3]
                    indexnum = t1portlistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2portlistid[indexnum])
                    describe = describe.replace(indexid5, listpart)
        index3 = describe.find('destinationIPListID')
        if index3 != -1:
            indexpart = describe[index3+19:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+19+endIndex3]
                    indexnum = t1iplistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2iplistid[indexnum])
                    describe = describe.replace(indexid5, listpart)
        index3 = describe.find('destinationMACListID')
        if index3 != -1:
            indexpart = describe[index3+20:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+20+endIndex3]
                    indexnum = t1maclistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2maclistid[indexnum])
                    describe = describe.replace(indexid5, listpart)
        index3 = describe.find('destinationPortListID')
        if index3 != -1:
            indexpart = describe[index3+21:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+21+endIndex3]
                    indexnum = t1portlistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2portlistid[indexnum])
                    describe = describe.replace(indexid5, listpart)

        allfirewallrule[count] = describe
    print("Searching for firewall rule IDs in tenant 2...")
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

                        payload = allfirewallrule[count]
                        url = url_link_final_2 + 'api/firewallrules/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                        print(indexid)
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allfirewallruleidnew1.append(str(indexid))
                            allfirewallruleidold.append(count) 

                            payload = allfirewallrule[count]
                            url = url_link_final_2 + 'api/firewallrules/' + str(indexid)
                            headers = {
                            "api-secret-key": tenant2key,
                            "api-version": "v1",
                            "Content-Type": "application/json",
                            }
                            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
                            print(indexid)

        else:
            allfirewallcustomrule.append(count)



    #print("Tenant 2 default firewall rules")
    #print(allfirewallruleidnew1)
    print("Done!")
    return allfirewallrule, allfirewallruleidnew1, allfirewallruleidold, allfirewallcustomrule

def FirewallCustom(allfirewallrule, allfirewallcustomrule):
    allfirewallruleidnew2 = []
    if allfirewallcustomrule:
        print("Creating Firewall Custom Rule...")
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
                        print(indexid)
                    else:
                        endIndex = indexpart.find('}', startIndex + 1)
                        if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                            indexid = indexpart[startIndex+1:endIndex]
                            allfirewallruleidnew2.append(str(indexid))
                            print(indexid)
    #print("all new firewall rule custom rule")
    #print(allfirewallruleidnew2)
        print("Done!")
    return allfirewallruleidnew2

def FirewallReplace(allofpolicy, allfirewallruleidnew1, allfirewallruleidnew2, firewallruleid, allfirewallruleidold, allfirewallcustomrule, t1statefulid, t2statefulid):
    for count, describe in enumerate(allofpolicy):
        index = describe.find('\"firewall\"')
        if index != -1:
            indexpart = describe[index+9:]
            startIndex = indexpart.find('}')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find('}', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex]
                    index3 = indexid.find('globalStatefulConfigurationID')
                    if index3 != -1:
                        indexpart = indexid[index3+29:]
                        startIndex = indexpart.find(':')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex3 = indexpart.find(',', startIndex + 1)
                            if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex3]
                                indexid5 = indexid[index3:index3+29+endIndex3]
                                indexnum = t1statefulid.index(indexid1)
                                statefulpart = indexid5.replace(indexid1, t2statefulid[indexnum])
                                describe = describe.replace(indexid5, statefulpart)
                    index2 = indexid.find('ruleIDs')
                    if index2 != -1:
                        indexpart2 = indexid[index2+9:]
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
    return allofpolicy

def IPSappGet(allofpolicy):
    ipsappid = []
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
                        indexpart = indexid[index+18:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                ipsappid.extend(indexid2)
    ipsappid = list(dict.fromkeys(ipsappid))
    print(ipsappid)
    return ipsappid

def IPSappDescribe(ipsappid, t1portlistid, t2portlistid):
    allipsapp = []
    allipsappname = []
    allipsappidnew1 = []
    allipsappidold = []
    allipscustomapp = []

    print("Searching IPS application types in Tenant 2...")  
    for count, dirlist in enumerate(ipsappid):
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
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    allipsappname.append(str(indexid))
        index3 = describe.find('portListID')
        if index3 != -1:
            indexpart = describe[index3+10:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    indexid5 = describe[index3:index3+10+endIndex3]
                    indexnum = t1portlistid.index(indexid1)
                    listpart = indexid5.replace(indexid1, t2portlistid[indexnum])
                    allipsapp[count] = describe.replace(indexid5, listpart)
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

                        payload = allipsapp[count]
                        url = url_link_final_2 + 'api/applicationtypes/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        else:
            allipscustomapp.append(count)
    print("Tenant 2 default IPS application type")
    print(allipsappidnew1)
    return allipsapp, allipsappidnew1, allipsappidold, allipscustomapp

def IPSappCustom(allipsapp, allipscustomapp):
    allipsappidnew2 = []
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
    return allipsappidnew2

def IPSappReplace(allofpolicy, allipsappidnew1, allipsappidnew2, ipsappid, allipsappidold, allipscustomapp):
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
                        indexpart2 = indexid[index2+9:]
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
    return allofpolicy

def IPSGet(allofpolicy):
    ipsruleid = []
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
                        indexpart = indexid[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                ipsruleid.extend(indexid2)
    ipsruleid = list(dict.fromkeys(ipsruleid))
    print(ipsruleid)
    return ipsruleid

def IPSDescribe(ipsruleid, ipsappid, allipsappidnew1, allipsappidnew2, allipsappidold, allipscustomapp):
    allipsrule = []
    allipsrulename = []
    allipsruleidnew1 = []
    allipsruleidold = []
    allipscustomrule = []
    print("Searching IPS rules in Tenant 2...")
    for count, dirlist in enumerate(ipsruleid):
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
                endIndex = indexpart.find('\"description\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-2]
                    allipsrulename.append(str(indexid))
        index3 = describe.find('applicationTypeID')
        if index3 != -1:
            indexpart = describe[index3+17:]
            startIndex = indexpart.find(':')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex3 = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex3 != -1: #i.e. both quotes were found
                    indexid1 = indexpart[startIndex+1:endIndex3]
                    checkindex = ipsappid.index(indexid1)
                    if checkindex in allipsappidold:
                        checkindex1 = allipsappidold.index(checkindex)
                        replaceid = allipsappidnew1[checkindex1]
                    elif checkindex in allipscustomapp:
                        checkindex1 = allipscustomapp.index(checkindex)
                        replaceid = allipsappidnew2[checkindex1]
                    indexid5 = describe[index3:index3+17+endIndex3]
                    listpart = indexid5.replace(indexid1, replaceid)
                    allipsrule[count] = describe.replace(indexid5, listpart)

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
    return allipsrule, allipsruleidnew1, allipsruleidold, allipscustomrule

def IPSCustom(allipsrule, allipscustomrule):
    allipsruleidnew2 = []
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
    return allipsruleidnew2

def IPSReplace(allofpolicy, allipsruleidnew1, allipsruleidnew2, ipsruleid, allipsruleidold, allipscustomrule):
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
                        indexpart2 = indexid[index2+9:]
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
    return allofpolicy

def LIGet(allofpolicy):
    liruleid = []
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
                        indexpart = indexid[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                liruleid.extend(indexid2)
    liruleid = list(dict.fromkeys(liruleid))
    print(liruleid) 
    return liruleid

def LIDescribe(liruleid):
    alllirule = []
    alllirulename = []
    allliruleidnew1 = []
    allliruleidold = []
    alllicustomrule = []
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
                endIndex = indexpart.find('\"description\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-2]
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
    return alllirule, allliruleidnew1, allliruleidold, alllicustomrule

def LICustom(alllirule, alllicustomrule):
    allliruleidnew2 = []
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
    return allliruleidnew2

def LIReplace(allofpolicy, allliruleidnew1, allliruleidnew2, liruleid, allliruleidold, alllicustomrule):
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
                        indexpart2 = indexid[index2+9:]
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
    return allofpolicy

def IMGet(allofpolicy):
    imruleid = []
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
                        indexpart = indexid[index+9:]
                        startIndex = indexpart.find('[')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(']', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid1 = indexpart[startIndex+1:endIndex]
                                indexid2 = indexid1.split(",")
                                imruleid.extend(indexid2)
    imruleid = list(dict.fromkeys(imruleid))
    print(imruleid)
    return imruleid

def IMDescribe(imruleid):
    allimrule = []
    allimrulename = []
    allimruleidnew1 =[]
    allimruleidold = []
    allimcustomrule =[]
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
                endIndex = indexpart.find('\"description\"', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-2]
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
    return allimrule, allimruleidnew1, allimruleidold, allimcustomrule

def IMCustom(allimrule, allimcustomrule):
    allimruleidnew2 = []
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
    return allimruleidnew2

def IMReplace(allofpolicy, allimruleidnew1, allimruleidnew2, imruleid, allimruleidold, allimcustomrule):
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
                        indexpart2 = indexid[index2+7:]
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
    return allofpolicy

def AddPolicy(allofpolicy):
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
            if namecheck != -1:
                index = describe.find('name already exists')
                if index != -1:
                    describe1 = allofpolicy[count]
                    index = describe1.find('\"name\"')
                    if index != -1:
                        indexpart = describe1[index+6:]
                        startIndex = indexpart.find('\"')
                        if startIndex != -1: #i.e. if the first quote was found
                            endIndex = indexpart.find(',', startIndex + 1)
                            if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                                indexid = indexpart[startIndex+1:endIndex-1]
                                startIndex2 = indexid.find('{')
                                if startIndex2 != -1:
                                    endIndex2 = indexid.find('}', startIndex2 + 1)
                                    if startIndex2 != -1 and endIndex2 != -1: #i.e. both quotes were found
                                        indexid = indexid[startIndex2+1:endIndex2]
                                        dirlist = describe1[:index+6+startIndex+startIndex2+1] + str(rename) + describe1[index+6+startIndex+startIndex2+endIndex2-2:]
                                        rename = rename + 1                      
                                else:
                                    newname = indexid + " {" + str(rename) + "}"
                                    dirlist = describe1[:index+6+startIndex+1] + newname + describe1[index+6+startIndex+endIndex-2:]
                                    rename = rename + 1   
                else:
                    print(describe)
                    namecheck = -1

def ListScheduledTask():
	payload = {}
	url = url_link_final + 'api/scheduledtasks'
	headers = {
		"api-secret-key": tenant1key,
		"api-version": "v1",
		"Content-Type": "application/json",
	}
	response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
	describe = str(response.text)
	index = 0
	oldstname = []
	oldstid = []
	while index != -1:
	    index = describe.find('\"name\"')
	    if index != -1:
	        indexpart = describe[index+6:]
	        startIndex = indexpart.find('\"')
	        if startIndex != -1: 
	            endIndex = indexpart.find(',', startIndex + 1)
	            if startIndex != -1 and endIndex != -1: 
	                indexid = indexpart[startIndex+1:endIndex-1]
	                oldstname.append(str(indexid))
	    index = describe.find('\"ID\"')
	    if index != -1:
	        indexpart = describe[index+4:]
	        startIndex = indexpart.find(':')
	        if startIndex != -1: 
	            endIndex = indexpart.find(',', startIndex + 1)
	            if startIndex != -1 and endIndex != -1: 
	                indexid = indexpart[startIndex+1:endIndex]
	                oldstid.append(str(indexid))
	                describe = indexpart[endIndex:]
	            else:
	                endIndex = indexpart.find('}', startIndex + 1)
	                if startIndex != -1 and endIndex != -1: 
	                    indexid = indexpart[startIndex+1:endIndex]
	                    oldstid.append(str(indexid))
	                    describe = indexpart[endIndex:]
        
                    
	print("List of your Tasks:")
	print()
	for count, here in enumerate(oldstname):
	    print("ID: "+ str(oldstid[count]) + " || NAME: "+ here)
	    print()

def GetScheduledTask(stIDs):
    allst = []
    namest = []
    print ('Getting Target Task...')
    for part in stIDs.split():
        payload = {}
        url = url_link_final + 'api/scheduledtasks/' + str(part)
        headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
        describe = str(response.text)
        allst.append(describe)
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    namest.append(str(indexid))
                    describe = indexpart[endIndex:]
    print(allst)
    print(namest)
    return allst, namest

def CreateScheduledTask(allst, namest):
    print ('Creating Task to target Account...')
    for count, dirlist in enumerate(namest):
        print(dirlist)
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/scheduledtasks/search'
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
                        payload = allst[count]
                        url = url_link_final_2 + 'api/scheduledtasks/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        else:
            payload = allst[count]
            url = url_link_final_2 + 'api/scheduledtasks'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            
        print(str(response.text))

def ListEventTask():
    payload = {}
    url = url_link_final + 'api/eventbasedtasks'
    headers = {
    "api-secret-key": tenant1key,
    "api-version": "v1",
    "Content-Type": "application/json",
    }
    response = requests.request("GET", url, headers=headers, data=payload, verify=cert)
    describe = str(response.text)
    index = 0
    oldetname = []
    oldetid = []
    while index != -1:
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: 
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: 
                    indexid = indexpart[startIndex+1:endIndex-1]
                    oldetname.append(str(indexid))
        index = describe.find('\"ID\"')
        if index != -1:
            indexpart = describe[index+4:]
            startIndex = indexpart.find(':')
            if startIndex != -1: 
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: 
                    indexid = indexpart[startIndex+1:endIndex]
                    oldetid.append(str(indexid))
                    describe = indexpart[endIndex:]
                else:
                    endIndex = indexpart.find('}', startIndex + 1)
                    if startIndex != -1 and endIndex != -1: 
                        indexid = indexpart[startIndex+1:endIndex]
                        oldetid.append(str(indexid))
                        describe = indexpart[endIndex:]
        
                    
    print("List of your Tasks")
    print()
    for count, here in enumerate(oldetname):
        print("ID: "+ str(oldetid[count]) + " || NAME: "+ here)
        print()

def GetEventTask(etIDs):
    allet = []
    nameet = []
    print ('Getting Target Task...')
    for part in etIDs.split():
        payload = {}
        url = url_link_final + 'api/eventbasedtasks/' + str(part)
        headers = {
        "api-secret-key": tenant1key,
        "api-version": "v1",
        "Content-Type": "application/json",
        }
        response = requests.request("GET", url, headers=headers, data=payload, verify=cert)

        describe = str(response.text)
        allet.append(describe)
        index = describe.find('\"name\"')
        if index != -1:
            indexpart = describe[index+6:]
            startIndex = indexpart.find('\"')
            if startIndex != -1: #i.e. if the first quote was found
                endIndex = indexpart.find(',', startIndex + 1)
                if startIndex != -1 and endIndex != -1: #i.e. both quotes were found
                    indexid = indexpart[startIndex+1:endIndex-1]
                    nameet.append(str(indexid))
                    describe = indexpart[endIndex:]
    print(allet)
    print(nameet)
    return allet, nameet

def CreateEventTask(allet, nameet):
    print ('Creating Task to target Account...')
    for count, dirlist in enumerate(nameet):
        payload = "{\"searchCriteria\": [{\"fieldName\": \"name\",\"stringValue\": \"" + dirlist + "\"}]}"
        url = url_link_final_2 + 'api/eventbasedtasks/search'
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
                        payload = allet[count]
                        url = url_link_final_2 + 'api/eventbasedtasks/' + str(indexid)
                        headers = {
                        "api-secret-key": tenant2key,
                        "api-version": "v1",
                        "Content-Type": "application/json",
                        }
                        response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
        else:
            payload = allet[count]
            url = url_link_final_2 + 'api/eventbasedtasks'
            headers = {
            "api-secret-key": tenant2key,
            "api-version": "v1",
            "Content-Type": "application/json",
            }
            response = requests.request("POST", url, headers=headers, data=payload, verify=cert)
            
        print(str(response.text))

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
        antimalwareconfig, allofpolicy = GetPolicy(policyIDs)
        directorylist, fileextentionlist, filelist, allamconfig = AMconfigtenant1(antimalwareconfig)
        alldirectory = DirListTenant1(directorylist)
        allfileextention = FileExtensionListTenant1(fileextentionlist)               
        allfilelist = FileListTenant1(filelist)
        alldirectory, allfilelist, allfileextention = RenameLists(alldirectory, allfilelist, allfileextention)     
        #create each list to tenant 2                  
        alldirectorynew = DirListTenant2(alldirectory)
        allfileextentionnew = FileExtensionListTenant2(allfileextention)
        allfilelistnew = FileListTenant2(allfilelist)
    #Check AM Config lists and replace the old one
        allamconfig = AmConfigCheck(allamconfig, directorylist, alldirectorynew, fileextentionlist, allfileextentionnew, filelist, allfilelistnew)
    #Rename AM Configs
        allamconfig = RenameAmConfig(allamconfig)
    #create AM Configs to tenant 2
        allamconfignew = AmconfigTenant2(allamconfig)
    #Replace old AM config with new AM config
        allofpolicy = AmReplaceConfig(allofpolicy, antimalwareconfig, allamconfignew)
    #Rename Policy
        allofpolicy = RenamePolicy(allofpolicy)
    #List tranfer
        t1iplistall, t1iplistname, t1iplistid = IpListGet()
        t2iplistid = IpListCreate(t1iplistall, t1iplistname)
        t1maclistall, t1maclistname, t1maclistid = MacListGet()
        t2maclistid = MacListCreate(t1maclistall, t1maclistname)
        t1portlistall, t1portlistname, t1portlistid = PortListGet()
        t2portlistid = PortListCreate(t1portlistall, t1portlistname)
    #Other transfer
        t1statefulall, t1statefulname, t1statefulid = StatefulGet()
        t2statefulid = StatefulCreate(t1statefulall, t1statefulname)
#all about Firewall rules
        firewallruleid, policystateful = FirewallGet(allofpolicy)
        allfirewallrule, allfirewallruleidnew1, allfirewallruleidold, allfirewallcustomrule = FirewallDescribe(firewallruleid, t1iplistid, t2iplistid, t1maclistid, t2maclistid, t1portlistid, t2portlistid)
    #Create custom Firewall rules
        allfirewallruleidnew2 = FirewallCustom(allfirewallrule, allfirewallcustomrule)
    #replace old firewall rule with tenant 2
        allofpolicy = FirewallReplace(allofpolicy, allfirewallruleidnew1, allfirewallruleidnew2, firewallruleid, allfirewallruleidold, allfirewallcustomrule, t1statefulid, t2statefulid)
#all about IPS rules
    #find all IPS application ID
        ipsappid = IPSappGet(allofpolicy)
    #describe IPS app ID
        allipsapp, allipsappidnew1, allipsappidold, allipscustomapp = IPSappDescribe(ipsappid,t1portlistid,t2portlistid)
    #Create custom IPS app
        allipsappidnew2 = IPSappCustom(allipsapp, allipscustomapp)
    #replace old ips app with tenant 2
        allofpolicy = IPSappReplace(allofpolicy, allipsappidnew1, allipsappidnew2, ipsappid, allipsappidold, allipscustomapp)

    #find all ips rules
        ipsruleid = IPSGet(allofpolicy)
    #describe IPS rule
        allipsrule, allipsruleidnew1, allipsruleidold, allipscustomrule = IPSDescribe(ipsruleid, ipsappid, allipsappidnew1, allipsappidnew2, allipsappidold, allipscustomapp)
    #Create custom IPS rules
        allipsruleidnew2 = IPSCustom(allipsrule, allipscustomrule)
    #replace old IPS rule with tenant 2
        allofpolicy = IPSReplace(allofpolicy, allipsruleidnew1, allipsruleidnew2, ipsruleid, allipsruleidold, allipscustomrule)
#all about log rules
    #find all log rules
        liruleid = LIGet(allofpolicy)
    #describe log rule
        alllirule, allliruleidnew1, allliruleidold, alllicustomrule = LIDescribe(liruleid)
    #Create custom LI rules
        allliruleidnew2 = LICustom(alllirule, alllicustomrule)
    #replace old LI rule with tenant 2
        allofpolicy = LIReplace(allofpolicy, allliruleidnew1, allliruleidnew2, liruleid, allliruleidold, alllicustomrule)
#all about IM rules
    #find all IM rules
        imruleid = IMGet(allofpolicy)
    #describe IM rule
        allimrule, allimruleidnew1, allimruleidold, allimcustomrule = IMDescribe(imruleid)
    #Create custom IM rules
        allimruleidnew2 = IMCustom(allimrule, allimcustomrule)
    #replace old IM rule with tenant 2
        allofpolicy = IMReplace(allofpolicy, allimruleidnew1, allimruleidnew2, imruleid, allimruleidold, allimcustomrule)
    #create Policy to tenant 2    
        AddPolicy(allofpolicy)
        sys.exit()
    elif Input1 == "2":
        ListEventTask()
        etIDs = input("Input Event Based Task ID/s (if more than one, put space between each ID): ")
        allet, nameet = GetEventTask(etIDs)
        CreateEventTask(allet, nameet)
        sys.exit()
    elif Input1 == "3":
        ListScheduledTask()
        stIDs = input("Input Scheduled Task ID/s (if more than one, put space between each ID): ")
        allst, namest = GetScheduledTask(stIDs)
        CreateScheduledTask(allst, namest)
        sys.exit()
    else:
        print("Please choose a number")
        Migrate()


Migrate()
sys.exit()
