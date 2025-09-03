from setuptools import find_packages, setup

package_name = 'rerun_logger'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=[
        'setuptools',
        'rerun-sdk'
        ],
    zip_safe=True,
    maintainer='redbackbots',
    maintainer_email='james.thomson@rmit.edu.au',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'logger = rerun_logger.logger:main'
        ],
    },
)
